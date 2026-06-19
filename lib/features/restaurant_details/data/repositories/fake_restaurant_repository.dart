import 'package:dartz/dartz.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_restaurant_data.dart';
import '../models/menu_category_model.dart';
import '../models/menu_item_model.dart';
import '../models/review_model.dart';
import 'restaurant_repository.dart';

class FakeRestaurantRepository implements RestaurantRepository {
  // Simulate network delay
  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<Either<Failure, RestaurantModel>> getRestaurantDetails(String id) async {
    try {
      await _delay();
      final restaurant = MockRestaurantData.mockRestaurants.firstWhere((r) => r.id == id);
      return Right(restaurant);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuCategoryModel>>> getMenuCategories(String restaurantId) async {
    try {
      await _delay();
      return Right(MockRestaurantData.categories);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenuItems(String restaurantId, String categoryId) async {
    try {
      await _delay();
      final items = MockRestaurantData.menuItems
          .where((item) => item.categoryId == categoryId)
          .toList();
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewModel>>> getReviews(String restaurantId) async {
    try {
      await _delay();
      return Right(MockRestaurantData.reviews);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(String restaurantId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // In a real app, this would toggle the state in the backend.
      // Here we just return true to simulate success.
      return const Right(true);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(MenuItemModel item, int quantity) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
