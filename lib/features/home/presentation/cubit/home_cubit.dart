import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/home_repository.dart';
import '../../data/models/category_model.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../../data/models/offer_model.dart';
import '../../data/models/food_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(const HomeState());

  /// Fetches all home data in parallel.
  Future<void> getHomeData() async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final results = await Future.wait([
        _homeRepository.getCategories(),
        _homeRepository.getRestaurants(),
        _homeRepository.getOffers(),
        _homeRepository.getMeals(),
      ]);

      final categoriesResult = results[0];
      final restaurantsResult = results[1];
      final offersResult = results[2];
      final mealsResult = results[3];

      categoriesResult.fold(
        (failure) => emit(state.copyWith(status: HomeStatus.failure, error: failure.message)),
        (categories) {
          restaurantsResult.fold(
            (failure) => emit(state.copyWith(status: HomeStatus.failure, error: failure.message)),
            (restaurants) {
              offersResult.fold(
                (failure) => emit(state.copyWith(status: HomeStatus.failure, error: failure.message)),
                (offers) {
                  mealsResult.fold(
                    (failure) => emit(state.copyWith(status: HomeStatus.failure, error: failure.message)),
                    (meals) => emit(state.copyWith(
                      status: HomeStatus.success,
                      categories: categories as List<CategoryModel>,
                      restaurants: restaurants as List<RestaurantModel>,
                      offers: offers as List<OfferModel>,
                      meals: meals as List<FoodModel>,
                    )),
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, error: e.toString()));
    }
  }

  /// Triggers a refresh of the home data.
  Future<void> refresh() => getHomeData();

  /// Searches for restaurants based on a query.
  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      refresh();
      return;
    }

    emit(state.copyWith(status: HomeStatus.loading));
    final result = await _homeRepository.getRestaurants(query: query);
    result.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.failure, error: failure.message)),
      (restaurants) => emit(state.copyWith(
        status: HomeStatus.success,
        restaurants: restaurants,
      )),
    );
  }

  /// Filters restaurants by category.
  Future<void> filterByCategory(String categoryName) async {
    emit(state.copyWith(status: HomeStatus.loading));
    
    // In a real app, this might be an API call.
    // For fake data, we filter the local list or re-fetch.
    final result = await _homeRepository.getRestaurants();
    result.fold(
      (failure) => emit(state.copyWith(status: HomeStatus.failure, error: failure.message)),
      (restaurants) {
        final filtered = restaurants.where((r) => r.cuisine.toLowerCase().contains(categoryName.toLowerCase())).toList();
        emit(state.copyWith(
          status: HomeStatus.success,
          restaurants: filtered,
        ));
      },
    );
  }

  /// Simulates an error state for testing purposes.
  void simulateError() {
    emit(state.copyWith(status: HomeStatus.failure, error: 'Simulated error occurred!'));
  }
}
