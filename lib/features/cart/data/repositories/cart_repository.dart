import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/cart_item_model.dart';
import '../models/coupon_model.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItemModel>>> getCartItems();
  
  Future<Either<Failure, List<CartItemModel>>> addItemToCart(CartItemModel item);
  
  Future<Either<Failure, List<CartItemModel>>> removeItemFromCart(String itemId);
  
  Future<Either<Failure, List<CartItemModel>>> updateItemQuantity(String itemId, int newQuantity);
  
  Future<Either<Failure, CouponModel>> validateCoupon(String code);
  
  Future<Either<Failure, void>> clearCart();
}
