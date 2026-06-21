import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_order_tracking_data.dart';
import '../models/order_tracking_model.dart';
import 'order_tracking_repository.dart';

/// Fake implementation of [OrderTrackingRepository] using mock data.
class FakeOrderTrackingRepository implements OrderTrackingRepository {
  /// Simulates network delay.
  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 1200));

  @override
  Future<Either<Failure, OrderTrackingModel>> getTrackingInfo(String orderId) async {
    try {
      await _delay();
      return Right(MockOrderTrackingData.activeOrderTracking);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
