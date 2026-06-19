import 'package:dartz/dartz.dart';
import 'package:food_app/features/restaurant_details/data/mock/mock_restaurant_data.dart';
import '../../../../core/errors/failures.dart';
import '../models/category_model.dart';
import '../models/offer_model.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../models/food_model.dart';
import '../models/mock_categories.dart';
import '../models/mock_offers.dart';
import '../models/mock_meals.dart';
import 'home_repository.dart';

/// Fake implementation of [HomeRepository] for demo and local testing.
class FakeHomeRepository implements HomeRepository {
  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    // Simulated network delay (500–1200ms)
    await Future.delayed(const Duration(milliseconds: 800));
    return Right(mockCategories);
  }

  @override
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants({String? query}) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final restaurants = MockRestaurantData.mockRestaurants;
    if (query != null && query.isNotEmpty) {
      final filtered = restaurants.where(
        (r) => r.name.toLowerCase().contains(query.toLowerCase()) || 
               r.cuisine.toLowerCase().contains(query.toLowerCase())
      ).toList();
      return Right(filtered);
    }
    return Right(restaurants);
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return Right(mockOffers);
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getMeals() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return Right(mockMeals);
  }
}
