import 'driver_model.dart';
import 'tracking_timeline_model.dart';

class OrderTrackingModel {
  final String id;
  final String restaurantName;
  final String restaurantImage;
  final int etaMinutes;
  final String status;
  final DriverModel? driver;
  final List<TrackingTimelineModel> timeline;

  OrderTrackingModel({
    required this.id,
    required this.restaurantName,
    required this.restaurantImage,
    required this.etaMinutes,
    required this.status,
    this.driver,
    required this.timeline,
  });

  factory OrderTrackingModel.fromJson(Map<String, dynamic> json) {
    return OrderTrackingModel(
      id: json['id'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      restaurantImage: json['restaurantImage'] ?? '',
      etaMinutes: json['etaMinutes'] ?? 0,
      status: json['status'] ?? '',
      driver: json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      timeline: (json['timeline'] as List?)
              ?.map((item) => TrackingTimelineModel.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'restaurantImage': restaurantImage,
      'etaMinutes': etaMinutes,
      'status': status,
      'driver': driver?.toJson(),
      'timeline': timeline.map((item) => item.toJson()).toList(),
    };
  }

  OrderTrackingModel copyWith({
    String? id,
    String? restaurantName,
    String? restaurantImage,
    int? etaMinutes,
    String? status,
    DriverModel? driver,
    List<TrackingTimelineModel>? timeline,
  }) {
    return OrderTrackingModel(
      id: id ?? this.id,
      restaurantName: restaurantName ?? this.restaurantName,
      restaurantImage: restaurantImage ?? this.restaurantImage,
      etaMinutes: etaMinutes ?? this.etaMinutes,
      status: status ?? this.status,
      driver: driver ?? this.driver,
      timeline: timeline ?? this.timeline,
    );
  }

  factory OrderTrackingModel.fake() {
    return OrderTrackingModel(
      id: 'FG-48291',
      restaurantName: "L'Arte della Pasta",
      restaurantImage: '',
      etaMinutes: 15,
      status: 'On the Way',
      driver: DriverModel.fake(),
      timeline: List.generate(4, (_) => TrackingTimelineModel.fake()),
    );
  }
}
