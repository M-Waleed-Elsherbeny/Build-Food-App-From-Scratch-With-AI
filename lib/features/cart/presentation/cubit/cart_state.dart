import 'package:equatable/equatable.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/cart_summary_model.dart';
import '../../data/models/coupon_model.dart';

enum CartStatus {
  initial,
  loading,
  loaded,
  cartUpdated,
  couponApplied,
  checkoutReady,
  empty,
  error
}

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItemModel> items;
  final CouponModel? appliedCoupon;
  final CartSummaryModel summary;
  final String errorMsg;
  final bool isCouponLoading;

  const CartState({
    this.status = CartStatus.initial,
    this.items = const [],
    this.appliedCoupon,
    this.summary = const CartSummaryModel(
      subtotal: 0.0,
      deliveryFee: 0.0,
      taxAmount: 0.0,
      discountAmount: 0.0,
    ),
    this.errorMsg = '',
    this.isCouponLoading = false,
  });

  bool get isLoading => status == CartStatus.loading;

  CartState copyWith({
    CartStatus? status,
    List<CartItemModel>? items,
    CouponModel? appliedCoupon,
    CartSummaryModel? summary,
    String? errorMsg,
    bool? isCouponLoading,
    bool clearCoupon = false,
  }) {
    return CartState(
      status: status ?? this.status,
      items: items ?? this.items,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      summary: summary ?? this.summary,
      errorMsg: errorMsg ?? this.errorMsg,
      isCouponLoading: isCouponLoading ?? this.isCouponLoading,
    );
  }

  @override
  List<Object?> get props => [
        status,
        items,
        appliedCoupon,
        summary,
        errorMsg,
        isCouponLoading,
      ];
}
