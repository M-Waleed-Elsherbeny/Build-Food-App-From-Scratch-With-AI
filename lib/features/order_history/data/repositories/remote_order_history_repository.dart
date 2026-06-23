import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../models/order_history_model.dart';
import 'order_history_repository.dart';

/// Remote implementation of [OrderHistoryRepository] using [ApiClient].
/// Prepared for future API integration.
class RemoteOrderHistoryRepository implements OrderHistoryRepository {
  final ApiClient _apiClient;

  RemoteOrderHistoryRepository(this._apiClient);

  @override
  Future<Either<Failure, List<OrderHistoryModel>>> getHistory() async {
    try {
      // Future implementation:
      // final response = await _apiClient.get('/orders/history');
      // return Right((response.data as List).map((x) => OrderHistoryModel.fromJson(x)).toList());
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderHistoryModel>> getOrderDetail(String orderId) async {
    try {
      // Future implementation:
      // final response = await _apiClient.get('/orders/$orderId');
      // return Right(OrderHistoryModel.fromJson(response.data));
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
