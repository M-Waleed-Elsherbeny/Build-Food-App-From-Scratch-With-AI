import 'package:equatable/equatable.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';
import '../../data/models/menu_category_model.dart';
import '../../data/models/menu_item_model.dart';
import '../../data/models/review_model.dart';

enum RestaurantDetailsStatus { initial, loading, success, failure }

class RestaurantDetailsState extends Equatable {
  final RestaurantDetailsStatus status;
  final RestaurantModel? restaurant;
  final List<MenuCategoryModel> categories;
  final List<MenuItemModel> menuItems;
  final List<ReviewModel> reviews;
  final String? selectedCategoryId;
  final String? error;
  
  // Loading flags for specific interactions
  final bool isFavoriteUpdating;
  final bool isCartUpdating;

  const RestaurantDetailsState({
    this.status = RestaurantDetailsStatus.initial,
    this.restaurant,
    this.categories = const [],
    this.menuItems = const [],
    this.reviews = const [],
    this.selectedCategoryId,
    this.error,
    this.isFavoriteUpdating = false,
    this.isCartUpdating = false,
  });

  RestaurantDetailsState copyWith({
    RestaurantDetailsStatus? status,
    RestaurantModel? restaurant,
    List<MenuCategoryModel>? categories,
    List<MenuItemModel>? menuItems,
    List<ReviewModel>? reviews,
    String? selectedCategoryId,
    String? error,
    bool? isFavoriteUpdating,
    bool? isCartUpdating,
  }) {
    return RestaurantDetailsState(
      status: status ?? this.status,
      restaurant: restaurant ?? this.restaurant,
      categories: categories ?? this.categories,
      menuItems: menuItems ?? this.menuItems,
      reviews: reviews ?? this.reviews,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      error: error, // Clear error if not explicitly passed
      isFavoriteUpdating: isFavoriteUpdating ?? this.isFavoriteUpdating,
      isCartUpdating: isCartUpdating ?? this.isCartUpdating,
    );
  }

  @override
  List<Object?> get props => [
        status,
        restaurant,
        categories,
        menuItems,
        reviews,
        selectedCategoryId,
        error,
        isFavoriteUpdating,
        isCartUpdating,
      ];
}
