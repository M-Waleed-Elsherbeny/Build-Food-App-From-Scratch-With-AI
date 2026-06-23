import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../models/order_tracking_model.dart';
import 'order_tracking_repository.dart';

/// Remote implementation of [OrderTrackingRepository] using [ApiClient].
/// Prepared for future API integration.
class RemoteOrderTrackingRepository implements OrderTrackingRepository {
  final ApiClient _apiClient;

  RemoteOrderTrackingRepository(this._apiClient);

  @override
  Future<Either<Failure, OrderTrackingModel>> getTrackingInfo(String orderId) async {
    try {
      // Future implementation:
      // final response = await _apiClient.get('/orders/$orderId/tracking');
      // return Right(OrderTrackingModel.fromJson(response.data));
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
