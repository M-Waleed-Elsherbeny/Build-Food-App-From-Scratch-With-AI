import 'package:equatable/equatable.dart';
import '../../data/models/order_tracking_model.dart';

enum OrderTrackingStatus { initial, loading, success, failure }

class OrderTrackingState extends Equatable {
  final OrderTrackingStatus status;
  final OrderTrackingModel? trackingData;
  final String errorMsg;

  const OrderTrackingState({
    this.status = OrderTrackingStatus.initial,
    this.trackingData,
    this.errorMsg = '',
  });

  OrderTrackingState copyWith({
    OrderTrackingStatus? status,
    OrderTrackingModel? trackingData,
    String? errorMsg,
  }) {
    return OrderTrackingState(
      status: status ?? this.status,
      trackingData: trackingData ?? this.trackingData,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [status, trackingData, errorMsg];
}
