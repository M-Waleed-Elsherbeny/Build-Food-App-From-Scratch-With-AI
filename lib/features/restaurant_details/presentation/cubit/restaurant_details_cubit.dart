import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/repositories/restaurant_repository.dart';
import 'restaurant_details_state.dart';

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  final RestaurantRepository _repository;

  RestaurantDetailsCubit(this._repository) : super(const RestaurantDetailsState());

  Future<void> loadRestaurantData(String restaurantId) async {
    emit(state.copyWith(status: RestaurantDetailsStatus.loading));

    // Load basic details first
    final detailsResult = await _repository.getRestaurantDetails(restaurantId);
    
    await detailsResult.fold(
      (failure) async {
        emit(state.copyWith(
          status: RestaurantDetailsStatus.failure,
          error: failure.message,
        ));
      },
      (restaurant) async {
        emit(state.copyWith(restaurant: restaurant));
        
        // Then load categories and reviews
        final categoriesResult = await _repository.getMenuCategories(restaurantId);
        final reviewsResult = await _repository.getReviews(restaurantId);
        
        var categories = state.categories;
        var reviews = state.reviews;
        var errorMsg = '';

        categoriesResult.fold(
          (failure) => errorMsg = failure.message,
          (cats) => categories = cats,
        );

        reviewsResult.fold(
          (failure) => errorMsg = failure.message,
          (revs) => reviews = revs,
        );

        if (errorMsg.isNotEmpty && categories.isEmpty) {
          // Only fail if we can't get the core info needed to show the page
          emit(state.copyWith(
            status: RestaurantDetailsStatus.failure,
            error: errorMsg,
          ));
        } else {
          // If we have categories, load the first category's items
          String? selectedCategory;
          if (categories.isNotEmpty) {
            selectedCategory = categories.first.id;
          }

          emit(state.copyWith(
            categories: categories,
            reviews: reviews,
            selectedCategoryId: selectedCategory,
          ));

          if (selectedCategory != null) {
             await _loadMenuItems(restaurantId, selectedCategory);
          } else {
             emit(state.copyWith(status: RestaurantDetailsStatus.success));
          }
        }
      },
    );
  }

  Future<void> selectCategory(String categoryId) async {
    if (state.selectedCategoryId == categoryId || state.restaurant == null) return;
    
    emit(state.copyWith(
      selectedCategoryId: categoryId,
      status: RestaurantDetailsStatus.loading, // Show skeletonizer for menu items
    ));
    
    await _loadMenuItems(state.restaurant!.id, categoryId);
  }

  Future<void> _loadMenuItems(String restaurantId, String categoryId) async {
    final result = await _repository.getMenuItems(restaurantId, categoryId);
    
    result.fold(
      (failure) {
        emit(state.copyWith(
          status: RestaurantDetailsStatus.failure,
          error: failure.message,
        ));
      },
      (items) {
        emit(state.copyWith(
          status: RestaurantDetailsStatus.success,
          menuItems: items,
        ));
      },
    );
  }

  Future<void> toggleFavorite() async {
    if (state.restaurant == null) return;

    emit(state.copyWith(isFavoriteUpdating: true));

    final result = await _repository.toggleFavorite(state.restaurant!.id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isFavoriteUpdating: false,
          error: failure.message,
        ));
      },
      (_) {
        final currentFavorite = state.restaurant!.isFavorite;
        final updatedRestaurant = state.restaurant!.copyWith(isFavorite: !currentFavorite);
        
        emit(state.copyWith(
          isFavoriteUpdating: false,
          restaurant: updatedRestaurant,
        ));
      },
    );
  }

  Future<void> addToCart(MenuItemModel item, {int quantity = 1}) async {
    emit(state.copyWith(isCartUpdating: true));

    final result = await _repository.addToCart(item, quantity);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isCartUpdating: false,
          error: failure.message,
        ));
      },
      (_) {
        // Here you might want to also dispatch to a CartCubit, 
        // but for Restaurant details we just complete the action
        emit(state.copyWith(
          isCartUpdating: false,
        ));
      },
    );
  }
}
