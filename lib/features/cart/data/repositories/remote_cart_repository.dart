import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../models/cart_item_model.dart';
import '../models/coupon_model.dart';
import 'cart_repository.dart';

class RemoteCartRepository implements CartRepository {
  final Dio _dio;

  RemoteCartRepository(this._dio);

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItems() async {
    try {
      final response = await _dio.get('/cart');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final items = data.map((e) => CartItemModel.fromJson(e)).toList();
        return Right(items);
      }
      return const Left(ServerFailure('Failed to load cart items.'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred.'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> addItemToCart(CartItemModel item) async {
    try {
      final response = await _dio.post('/cart/items', data: item.toJson());
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final items = data.map((e) => CartItemModel.fromJson(e)).toList();
        return Right(items);
      }
      return const Left(ServerFailure('Failed to add item to cart.'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> removeItemFromCart(String itemId) async {
    try {
      final response = await _dio.delete('/cart/items/$itemId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final items = data.map((e) => CartItemModel.fromJson(e)).toList();
        return Right(items);
      }
      return const Left(ServerFailure('Failed to remove item from cart.'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> updateItemQuantity(String itemId, int newQuantity) async {
    try {
      final response = await _dio.patch(
        '/cart/items/$itemId',
        data: {'quantity': newQuantity},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final items = data.map((e) => CartItemModel.fromJson(e)).toList();
        return Right(items);
      }
      return const Left(ServerFailure('Failed to update quantity.'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    }
  }

  @override
  Future<Either<Failure, CouponModel>> validateCoupon(String code) async {
    try {
      final response = await _dio.post(
        '/cart/coupon/validate',
        data: {'code': code},
      );
      if (response.statusCode == 200) {
        final coupon = CouponModel.fromJson(response.data['data']);
        return Right(coupon);
      }
      return const Left(ValidationFailure('Invalid coupon code.'));
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
         return const Left(ValidationFailure('Invalid coupon code.'));
      }
      return Left(ServerFailure(e.message ?? 'Network error'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      final response = await _dio.delete('/cart');
      if (response.statusCode == 200) {
        return const Right(null);
      }
      return const Left(ServerFailure('Failed to clear cart.'));
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    }
  }
}
