import 'package:equatable/equatable.dart';
import '../../data/models/order_history_model.dart';

enum OrderHistoryStatus { initial, loading, loaded, paginating, filtered, empty, error }

enum OrderHistoryTab { active, past }

class OrderHistoryState extends Equatable {
  final OrderHistoryStatus status;
  final List<OrderHistoryModel> orders;
  final OrderHistoryTab selectedTab;
  final String searchQuery;
  final int currentPage;
  final bool hasReachedMax;
  final String errorMsg;

  const OrderHistoryState({
    this.status = OrderHistoryStatus.initial,
    this.orders = const [],
    this.selectedTab = OrderHistoryTab.active,
    this.searchQuery = '',
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.errorMsg = '',
  });

  /// Returns orders filtered by [selectedTab] and [searchQuery].
  List<OrderHistoryModel> get filteredOrders {
    List<OrderHistoryModel> tabFiltered;
    if (selectedTab == OrderHistoryTab.active) {
      tabFiltered = orders
          .where((o) => o.status == 'Preparing' || o.status == 'On the Way')
          .toList();
    } else {
      tabFiltered = orders.where((o) => o.status == 'Delivered').toList();
    }

    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      return tabFiltered
          .where((o) =>
              o.restaurantName.toLowerCase().contains(query) ||
              o.id.toLowerCase().contains(query))
          .toList();
    }
    return tabFiltered;
  }

  OrderHistoryState copyWith({
    OrderHistoryStatus? status,
    List<OrderHistoryModel>? orders,
    OrderHistoryTab? selectedTab,
    String? searchQuery,
    int? currentPage,
    bool? hasReachedMax,
    String? errorMsg,
  }) {
    return OrderHistoryState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      selectedTab: selectedTab ?? this.selectedTab,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [
        status,
        orders,
        selectedTab,
        searchQuery,
        currentPage,
        hasReachedMax,
        errorMsg,
      ];
}

