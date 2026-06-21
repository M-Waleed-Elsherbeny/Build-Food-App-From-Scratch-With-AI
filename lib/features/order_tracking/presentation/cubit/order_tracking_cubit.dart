import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/order_tracking_repository.dart';
import 'order_tracking_state.dart';

/// Cubit that manages the order tracking state.
class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final OrderTrackingRepository _repository;

  OrderTrackingCubit(this._repository) : super(const OrderTrackingState());

  /// Loads tracking information for the given [orderId].
  Future<void> loadTrackingInfo(String orderId) async {
    emit(state.copyWith(status: OrderTrackingStatus.loading));
    final result = await _repository.getTrackingInfo(orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrderTrackingStatus.failure,
        errorMsg: failure.message,
      )),
      (trackingData) => emit(state.copyWith(
        status: OrderTrackingStatus.success,
        trackingData: trackingData,
      )),
    );
  }
}
