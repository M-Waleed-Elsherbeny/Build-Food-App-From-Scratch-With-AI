import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/order_tracking_model.dart';
import '../../data/models/tracking_timeline_model.dart';
import '../../data/repositories/order_tracking_repository.dart';
import 'order_tracking_state.dart';

/// Cubit that manages the order tracking state and simulates live order status.
class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  final OrderTrackingRepository _repository;
  Timer? _simulationTimer;
  int _simulationStep = 0;

  OrderTrackingCubit(this._repository) : super(const OrderTrackingState());

  /// Loads tracking information for the given [orderId].
  Future<void> loadTrackingInfo(String orderId) async {
    emit(state.copyWith(status: OrderTrackingStatus.loading));
    final result = await _repository.getTrackingInfo(orderId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: OrderTrackingStatus.failure,
        errorMsg: failure.message,
      )),
      (trackingData) {
        emit(state.copyWith(
          status: OrderTrackingStatus.trackingLoaded,
          trackingData: trackingData,
        ));
        _startSimulation();
      },
    );
  }

  /// Simulates order progress and status updates.
  void _startSimulation() {
    _simulationTimer?.cancel();
    _simulationStep = 0;

    _simulationTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      if (state.trackingData == null) return;

      final currentData = state.trackingData!;
      _simulationStep++;

      if (_simulationStep == 1) {
        // Preparing status
        final updatedTimeline = List<TrackingTimelineModel>.from(currentData.timeline);
        updatedTimeline[0] = updatedTimeline[0].copyWith(isCompleted: true, isActive: false);
        updatedTimeline[1] = updatedTimeline[1].copyWith(isCompleted: false, isActive: true, time: '12:45 PM');
        
        final updatedData = currentData.copyWith(
          status: 'Preparing',
          etaMinutes: 12,
          timeline: updatedTimeline,
        );

        emit(state.copyWith(
          status: OrderTrackingStatus.statusUpdated,
          trackingData: updatedData,
        ));
      } else if (_simulationStep == 2) {
        // On the way status
        final updatedTimeline = List<TrackingTimelineModel>.from(currentData.timeline);
        updatedTimeline[1] = updatedTimeline[1].copyWith(isCompleted: true, isActive: false);
        updatedTimeline[2] = updatedTimeline[2].copyWith(isCompleted: false, isActive: true, time: '12:55 PM');

        final updatedData = currentData.copyWith(
          status: 'On the Way',
          etaMinutes: 5,
          timeline: updatedTimeline,
        );

        emit(state.copyWith(
          status: OrderTrackingStatus.statusUpdated,
          trackingData: updatedData,
        ));
      } else if (_simulationStep >= 3) {
        // Delivered status
        final updatedTimeline = List<TrackingTimelineModel>.from(currentData.timeline);
        updatedTimeline[2] = updatedTimeline[2].copyWith(isCompleted: true, isActive: false);
        updatedTimeline[3] = updatedTimeline[3].copyWith(isCompleted: true, isActive: true, time: '1:10 PM');

        final updatedData = currentData.copyWith(
          status: 'Delivered',
          etaMinutes: 0,
          timeline: updatedTimeline,
        );

        emit(state.copyWith(
          status: OrderTrackingStatus.delivered,
          trackingData: updatedData,
        ));
        _simulationTimer?.cancel();
      }
    });
  }

  /// Manually refreshes the tracking data.
  Future<void> refreshTrackingData() async {
    if (state.trackingData == null) return;
    final orderId = state.trackingData!.id;
    _simulationTimer?.cancel();
    await loadTrackingInfo(orderId);
  }

  @override
  Future<void> close() {
    _simulationTimer?.cancel();
    return super.close();
  }
}

