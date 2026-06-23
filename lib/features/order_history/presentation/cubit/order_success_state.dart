import 'package:equatable/equatable.dart';
import '../../data/models/order_success_model.dart';

enum OrderSuccessStatus { initial, successLoaded }

class OrderSuccessState extends Equatable {
  final OrderSuccessStatus status;
  final OrderSuccessModel? orderSuccessData;

  const OrderSuccessState({
    this.status = OrderSuccessStatus.initial,
    this.orderSuccessData,
  });

  OrderSuccessState copyWith({
    OrderSuccessStatus? status,
    OrderSuccessModel? orderSuccessData,
  }) {
    return OrderSuccessState(
      status: status ?? this.status,
      orderSuccessData: orderSuccessData ?? this.orderSuccessData,
    );
  }

  @override
  List<Object?> get props => [status, orderSuccessData];
}
