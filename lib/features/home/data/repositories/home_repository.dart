import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/category_model.dart';
import '../models/offer_model.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../models/food_model.dart';

abstract class HomeRepository {
  /// Fetches the list of food categories.
  Future<Either<Failure, List<CategoryModel>>> getCategories();

  /// Fetches the list of restaurants, optionally filtered by a search query.
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants({String? query});

  /// Fetches active offers and banners.
  Future<Either<Failure, List<OfferModel>>> getOffers();

  /// Fetches recommended meals.
  Future<Either<Failure, List<FoodModel>>> getMeals();
}
