import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_order_history_data.dart';
import '../models/order_history_model.dart';
import 'order_history_repository.dart';

/// Fake implementation of [OrderHistoryRepository] using mock data.
class FakeOrderHistoryRepository implements OrderHistoryRepository {
  /// Simulates network delay.
  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 1200));

  @override
  Future<Either<Failure, List<OrderHistoryModel>>> getHistory() async {
    try {
      await _delay();
      return Right(MockOrderHistoryData.mockOrders);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderHistoryModel>> getOrderDetail(String orderId) async {
    try {
      await _delay();
      final order = MockOrderHistoryData.mockOrders.firstWhere(
        (o) => o.id == orderId,
        orElse: () => MockOrderHistoryData.mockOrders.first,
      );
      return Right(order);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
