import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/order_tracking_model.dart';

/// Abstract contract for Order Tracking repository.
abstract class OrderTrackingRepository {
  /// Fetches the tracking info for a given [orderId].
  Future<Either<Failure, OrderTrackingModel>> getTrackingInfo(String orderId);
}
