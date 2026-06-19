import 'package:dartz/dartz.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';
import '../../../../core/errors/failures.dart';
import '../models/menu_category_model.dart';
import '../models/menu_item_model.dart';
import '../models/review_model.dart';

abstract class RestaurantRepository {
  Future<Either<Failure, RestaurantModel>> getRestaurantDetails(String id);
  Future<Either<Failure, List<MenuCategoryModel>>> getMenuCategories(String restaurantId);
  Future<Either<Failure, List<MenuItemModel>>> getMenuItems(String restaurantId, String categoryId);
  Future<Either<Failure, List<ReviewModel>>> getReviews(String restaurantId);
  Future<Either<Failure, bool>> toggleFavorite(String restaurantId);
  Future<Either<Failure, void>> addToCart(MenuItemModel item, int quantity);
}
