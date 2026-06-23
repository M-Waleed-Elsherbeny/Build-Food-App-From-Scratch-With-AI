import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_history_model.dart';
import '../../data/repositories/order_history_repository.dart';
import 'order_history_state.dart';

/// Cubit that manages order history, tab selection, search, and pagination.
class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderHistoryRepository _repository;

  OrderHistoryCubit(this._repository) : super(const OrderHistoryState());

  /// Loads all orders from the repository.
  Future<void> loadHistory() async {
    emit(state.copyWith(status: OrderHistoryStatus.loading));
    final result = await _repository.getHistory();
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrderHistoryStatus.error,
        errorMsg: failure.message,
      )),
      (orders) {
        if (orders.isEmpty) {
          emit(state.copyWith(
            status: OrderHistoryStatus.empty,
            orders: orders,
          ));
        } else {
          emit(state.copyWith(
            status: OrderHistoryStatus.loaded,
            orders: orders,
            currentPage: 1,
            hasReachedMax: false,
          ));
        }
      },
    );
  }

  /// Switches between [OrderHistoryTab.active] and [OrderHistoryTab.past].
  void selectTab(OrderHistoryTab tab) {
    emit(state.copyWith(
      selectedTab: tab,
      status: OrderHistoryStatus.filtered,
    ));
  }

  /// Filters orders by search query.
  void searchOrders(String query) {
    emit(state.copyWith(
      searchQuery: query,
      status: OrderHistoryStatus.filtered,
    ));
  }

  /// Simulates pagination to load the next page of orders.
  Future<void> loadNextPage() async {
    if (state.hasReachedMax || state.status == OrderHistoryStatus.paginating) return;

    emit(state.copyWith(status: OrderHistoryStatus.paginating));

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Generate simulated paginated orders
    final nextPage = state.currentPage + 1;
    final List<OrderHistoryModel> newOrders = List.generate(
      3,
      (index) => OrderHistoryModel(
        id: 'FG-PAG-${nextPage * 10 + index}',
        restaurantName: index == 0 ? "Zen Garden Kitchen" : "Morning Dew Bistro",
        restaurantImage: '',
        status: 'Delivered',
        date: 'Oct ${20 - nextPage}, 2023',
        items: state.orders.first.items,
        totalPrice: 15.50 + index * 4,
      ),
    );

    // Limit pagination to 3 pages for simulation
    final hasReachedMax = nextPage >= 3;

    emit(state.copyWith(
      status: OrderHistoryStatus.loaded,
      orders: List.from(state.orders)..addAll(newOrders),
      currentPage: nextPage,
      hasReachedMax: hasReachedMax,
    ));
  }
}

