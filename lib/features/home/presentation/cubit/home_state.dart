import 'package:equatable/equatable.dart';
import '../../data/models/category_model.dart';
import '../../data/models/offer_model.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../../data/models/food_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<CategoryModel> categories;
  final List<RestaurantModel> restaurants;
  final List<OfferModel> offers;
  final List<FoodModel> meals;
  final String? error;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.restaurants = const [],
    this.offers = const [],
    this.meals = const [],
    this.error,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<CategoryModel>? categories,
    List<RestaurantModel>? restaurants,
    List<OfferModel>? offers,
    List<FoodModel>? meals,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      restaurants: restaurants ?? this.restaurants,
      offers: offers ?? this.offers,
      meals: meals ?? this.meals,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, categories, restaurants, offers, meals, error];
}
