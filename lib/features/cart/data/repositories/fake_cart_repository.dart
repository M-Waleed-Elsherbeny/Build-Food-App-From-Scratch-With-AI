import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_cart_data.dart';
import '../models/cart_item_model.dart';
import '../models/coupon_model.dart';
import 'cart_repository.dart';

class FakeCartRepository implements CartRepository {
  final List<CartItemModel> _localCart = List.from(MockCartData.initialCartItems);

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItems() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      return Right(List.from(_localCart));
    } catch (e) {
      return const Left(ServerFailure('Failed to load cart items.'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> addItemToCart(
      CartItemModel item) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));
      final index = _localCart.indexWhere((element) => element.id == item.id);
      if (index >= 0) {
        final existingItem = _localCart[index];
        _localCart[index] = existingItem.copyWith(
            quantity: existingItem.quantity + item.quantity);
      } else {
        _localCart.add(item);
      }
      return Right(List.from(_localCart));
    } catch (e) {
      return const Left(ServerFailure('Failed to add item to cart.'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> removeItemFromCart(
      String itemId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _localCart.removeWhere((element) => element.id == itemId);
      return Right(List.from(_localCart));
    } catch (e) {
      return const Left(ServerFailure('Failed to remove item from cart.'));
    }
  }

  @override
  Future<Either<Failure, List<CartItemModel>>> updateItemQuantity(
      String itemId, int newQuantity) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final index = _localCart.indexWhere((element) => element.id == itemId);
      if (index >= 0) {
        if (newQuantity <= 0) {
          _localCart.removeAt(index);
        } else {
          _localCart[index] = _localCart[index].copyWith(quantity: newQuantity);
        }
      }
      return Right(List.from(_localCart));
    } catch (e) {
      return const Left(ServerFailure('Failed to update quantity.'));
    }
  }

  @override
  Future<Either<Failure, CouponModel>> validateCoupon(String code) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final index = MockCartData.validCoupons.indexWhere(
        (element) => element.code.toUpperCase() == code.toUpperCase(),
      );

      if (index >= 0) {
        return Right(MockCartData.validCoupons[index]);
      } else {
        return const Left(ValidationFailure('Invalid coupon code.'));
      }
    } catch (e) {
      return const Left(ServerFailure('Failed to validate coupon.'));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      _localCart.clear();
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to clear cart.'));
    }
  }
}
