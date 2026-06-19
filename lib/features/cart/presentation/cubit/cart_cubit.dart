import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/cart_summary_model.dart';
import '../../data/models/coupon_model.dart';
import '../../data/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository _cartRepository;

  CartCubit(this._cartRepository) : super(const CartState());

  static const double _deliveryFee = 5.0; // Fixed delivery fee for demo
  static const double _taxRate = 0.10;    // 10% tax rate

  Future<void> getCartItems() async {
    emit(state.copyWith(status: CartStatus.loading));
    final result = await _cartRepository.getCartItems();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CartStatus.error,
          errorMsg: failure.message,
        ));
      },
      (items) {
        _updateCartState(items, state.appliedCoupon);
      },
    );
  }

  Future<void> addItemToCart(CartItemModel item) async {
    final result = await _cartRepository.addItemToCart(item);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CartStatus.error,
          errorMsg: failure.message,
        ));
      },
      (items) {
        _updateCartState(items, state.appliedCoupon, isUpdated: true);
      },
    );
  }

  Future<void> removeItemFromCart(String itemId) async {
    final result = await _cartRepository.removeItemFromCart(itemId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CartStatus.error,
          errorMsg: failure.message,
        ));
      },
      (items) {
        _updateCartState(items, state.appliedCoupon, isUpdated: true);
      },
    );
  }

  Future<void> increaseQuantity(String itemId) async {
    final item = state.items.firstWhere((element) => element.id == itemId);
    await updateItemQuantity(itemId, item.quantity + 1);
  }

  Future<void> decreaseQuantity(String itemId) async {
    final item = state.items.firstWhere((element) => element.id == itemId);
    if (item.quantity > 1) {
      await updateItemQuantity(itemId, item.quantity - 1);
    } else {
      await removeItemFromCart(itemId);
    }
  }

  Future<void> updateItemQuantity(String itemId, int newQuantity) async {
    final result = await _cartRepository.updateItemQuantity(itemId, newQuantity);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CartStatus.error,
          errorMsg: failure.message,
        ));
      },
      (items) {
        _updateCartState(items, state.appliedCoupon, isUpdated: true);
      },
    );
  }

  Future<void> validateCoupon(String code) async {
    if (code.isEmpty) return;
    
    emit(state.copyWith(isCouponLoading: true));
    
    final result = await _cartRepository.validateCoupon(code);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: CartStatus.error,
          errorMsg: failure.message,
          isCouponLoading: false,
        ));
        // Reset to normal loaded state after showing error
        Future.delayed(const Duration(seconds: 1), () {
          if (!isClosed) emit(state.copyWith(status: CartStatus.loaded, errorMsg: ''));
        });
      },
      (coupon) {
        _updateCartState(state.items, coupon, isCouponApplied: true);
      },
    );
  }

  void removeCoupon() {
    _updateCartState(state.items, null, clearCoupon: true);
  }

  void checkout() {
    if (state.items.isEmpty) return;
    emit(state.copyWith(status: CartStatus.checkoutReady));
    
    // Simulate checkout process
    Future.delayed(const Duration(seconds: 2), () async {
       if (!isClosed) {
          await _cartRepository.clearCart();
          emit(const CartState(status: CartStatus.empty));
       }
    });
  }

  void _updateCartState(
    List<CartItemModel> items,
    CouponModel? coupon, {
    bool isUpdated = false,
    bool isCouponApplied = false,
    bool clearCoupon = false,
  }) {
    if (items.isEmpty) {
      emit(const CartState(status: CartStatus.empty));
      return;
    }

    final subtotal = items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    final taxAmount = subtotal * _taxRate;
    
    double discountAmount = 0.0;
    if (coupon != null) {
      discountAmount = subtotal * (coupon.discountPercentage / 100);
      if (discountAmount > coupon.maxDiscountAmount) {
        discountAmount = coupon.maxDiscountAmount;
      }
    }

    final summary = CartSummaryModel(
      subtotal: subtotal,
      deliveryFee: _deliveryFee,
      taxAmount: taxAmount,
      discountAmount: discountAmount,
    );

    CartStatus currentStatus = CartStatus.loaded;
    if (isUpdated) {
      currentStatus = CartStatus.cartUpdated;
    } else if (isCouponApplied) {
      currentStatus = CartStatus.couponApplied;
    }

    emit(state.copyWith(
      status: currentStatus,
      items: items,
      appliedCoupon: coupon,
      clearCoupon: clearCoupon,
      summary: summary,
      isCouponLoading: false,
    ));

    // Reset status to loaded if it was just a transient update status
    if (isUpdated || isCouponApplied) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!isClosed) {
          emit(state.copyWith(status: CartStatus.loaded));
        }
      });
    }
  }
}
