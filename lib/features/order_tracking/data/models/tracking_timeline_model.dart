class TrackingTimelineModel {
  final String title;
  final String time;
  final bool isCompleted;
  final bool isActive;
  final String description;

  TrackingTimelineModel({
    required this.title,
    required this.time,
    this.isCompleted = false,
    this.isActive = false,
    required this.description,
  });

  factory TrackingTimelineModel.fromJson(Map<String, dynamic> json) {
    return TrackingTimelineModel(
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      isActive: json['isActive'] ?? false,
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'isCompleted': isCompleted,
      'isActive': isActive,
      'description': description,
    };
  }

  TrackingTimelineModel copyWith({
    String? title,
    String? time,
    bool? isCompleted,
    bool? isActive,
    String? description,
  }) {
    return TrackingTimelineModel(
      title: title ?? this.title,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      isActive: isActive ?? this.isActive,
      description: description ?? this.description,
    );
  }

  factory TrackingTimelineModel.fake() {
    return TrackingTimelineModel(
      title: 'Order Confirmed',
      time: '12:30 PM',
      isCompleted: true,
      isActive: false,
      description: 'Your order has been confirmed.',
    );
  }
}
