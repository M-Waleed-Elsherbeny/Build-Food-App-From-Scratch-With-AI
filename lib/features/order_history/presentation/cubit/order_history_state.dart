import 'package:equatable/equatable.dart';
import '../../data/models/order_history_model.dart';

enum OrderHistoryStatus { initial, loading, success, failure }

enum OrderHistoryTab { active, past }

class OrderHistoryState extends Equatable {
  final OrderHistoryStatus status;
  final List<OrderHistoryModel> orders;
  final OrderHistoryTab selectedTab;
  final String errorMsg;

  const OrderHistoryState({
    this.status = OrderHistoryStatus.initial,
    this.orders = const [],
    this.selectedTab = OrderHistoryTab.active,
    this.errorMsg = '',
  });

  /// Returns orders filtered by [selectedTab].
  List<OrderHistoryModel> get filteredOrders {
    if (selectedTab == OrderHistoryTab.active) {
      return orders
          .where((o) => o.status == 'Preparing' || o.status == 'On the Way')
          .toList();
    }
    return orders.where((o) => o.status == 'Delivered').toList();
  }

  OrderHistoryState copyWith({
    OrderHistoryStatus? status,
    List<OrderHistoryModel>? orders,
    OrderHistoryTab? selectedTab,
    String? errorMsg,
  }) {
    return OrderHistoryState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      selectedTab: selectedTab ?? this.selectedTab,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [status, orders, selectedTab, errorMsg];
}
