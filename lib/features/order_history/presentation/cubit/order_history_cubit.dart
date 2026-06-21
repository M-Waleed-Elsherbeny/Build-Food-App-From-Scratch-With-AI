import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/order_history_repository.dart';
import 'order_history_state.dart';

/// Cubit that manages order history and tab selection.
class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderHistoryRepository _repository;

  OrderHistoryCubit(this._repository) : super(const OrderHistoryState());

  /// Loads all orders from the repository.
  Future<void> loadHistory() async {
    emit(state.copyWith(status: OrderHistoryStatus.loading));
    final result = await _repository.getHistory();
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrderHistoryStatus.failure,
        errorMsg: failure.message,
      )),
      (orders) => emit(state.copyWith(
        status: OrderHistoryStatus.success,
        orders: orders,
      )),
    );
  }

  /// Switches between [OrderHistoryTab.active] and [OrderHistoryTab.past].
  void selectTab(OrderHistoryTab tab) {
    emit(state.copyWith(selectedTab: tab));
  }
}
