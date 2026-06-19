import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../models/menu_category_model.dart';
import '../models/menu_item_model.dart';
import '../models/review_model.dart';
import 'restaurant_repository.dart';

class RemoteRestaurantRepository implements RestaurantRepository {
  final Dio _dio;

  RemoteRestaurantRepository(this._dio);

  @override
  Future<Either<Failure, RestaurantModel>> getRestaurantDetails(String id) async {
    try {
      // final response = await _dio.get('/api/v1/restaurants/$id');
      // return Right(RestaurantDetailsModel.fromJson(response.data['data']));
      throw UnimplementedError('API not connected yet');
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MenuCategoryModel>>> getMenuCategories(String restaurantId) async {
    try {
      // final response = await _dio.get('/api/v1/restaurants/$restaurantId/categories');
      // final List data = response.data['data'];
      // return Right(data.map((json) => MenuCategoryModel.fromJson(json)).toList());
      throw UnimplementedError('API not connected yet');
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<MenuItemModel>>> getMenuItems(String restaurantId, String categoryId) async {
    try {
      // final response = await _dio.get('/api/v1/restaurants/$restaurantId/menu', queryParameters: {'categoryId': categoryId});
      // final List data = response.data['data'];
      // return Right(data.map((json) => MenuItemModel.fromJson(json)).toList());
      throw UnimplementedError('API not connected yet');
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<ReviewModel>>> getReviews(String restaurantId) async {
    try {
      // final response = await _dio.get('/api/v1/restaurants/$restaurantId/reviews');
      // final List data = response.data['data'];
      // return Right(data.map((json) => ReviewModel.fromJson(json)).toList());
      throw UnimplementedError('API not connected yet');
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, bool>> toggleFavorite(String restaurantId) async {
    try {
      // final response = await _dio.post('/api/v1/favorites/toggle', data: {'restaurantId': restaurantId});
      // return Right(response.data['success'] ?? true);
      throw UnimplementedError('API not connected yet');
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(MenuItemModel item, int quantity) async {
    try {
      // final response = await _dio.post('/api/v1/cart/add', data: {'itemId': item.id, 'quantity': quantity});
      // return const Right(null);
      throw UnimplementedError('API not connected yet');
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
