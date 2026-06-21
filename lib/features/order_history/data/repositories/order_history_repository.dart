import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/order_history_model.dart';

/// Abstract contract for Order History repository.
abstract class OrderHistoryRepository {
  /// Fetches all order history (active + past).
  Future<Either<Failure, List<OrderHistoryModel>>> getHistory();

  /// Fetches detailed info for a single order by [orderId].
  Future<Either<Failure, OrderHistoryModel>> getOrderDetail(String orderId);
}
