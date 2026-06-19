import '../models/cart_item_model.dart';
import '../models/coupon_model.dart';

class MockCartData {
  static final List<CartItemModel> initialCartItems = [
    const CartItemModel(
      id: 'item_1',
      name: 'Classic Cheeseburger',
      price: 12.99,
      quantity: 1,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=600&auto=format&fit=crop',
      restaurantName: 'Burger Joint',
    ),
    const CartItemModel(
      id: 'item_2',
      name: 'Truffle Fries',
      price: 6.50,
      quantity: 2,
      imageUrl: 'https://images.unsplash.com/photo-1576107232684-1279f3908594?q=80&w=600&auto=format&fit=crop',
      restaurantName: 'Burger Joint',
    ),
    const CartItemModel(
      id: 'item_3',
      name: 'Spicy Chicken Sandwich',
      price: 14.50,
      quantity: 1,
      imageUrl: 'https://images.unsplash.com/photo-1606755962773-d324e0a13086?q=80&w=600&auto=format&fit=crop',
      restaurantName: 'Cluck & Co',
    ),
  ];

  static final List<CouponModel> validCoupons = [
    const CouponModel(
      code: 'WELCOME10',
      discountPercentage: 10.0,
      maxDiscountAmount: 5.0,
    ),
    const CouponModel(
      code: 'FOODIE20',
      discountPercentage: 20.0,
      maxDiscountAmount: 10.0,
    ),
  ];
}
