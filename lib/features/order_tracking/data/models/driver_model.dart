class DriverModel {
  final String name;
  final String avatar;
  final double rating;
  final String ratingsCount;
  final String phone;

  DriverModel({
    required this.name,
    required this.avatar,
    required this.rating,
    required this.ratingsCount,
    required this.phone,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingsCount: json['ratingsCount'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'rating': rating,
      'ratingsCount': ratingsCount,
      'phone': phone,
    };
  }

  DriverModel copyWith({
    String? name,
    String? avatar,
    double? rating,
    String? ratingsCount,
    String? phone,
  }) {
    return DriverModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      rating: rating ?? this.rating,
      ratingsCount: ratingsCount ?? this.ratingsCount,
      phone: phone ?? this.phone,
    );
  }

  factory DriverModel.fake() {
    return DriverModel(
      name: 'Ahmed K.',
      avatar: '',
      rating: 4.9,
      ratingsCount: '2.4k ratings',
      phone: '+201234567890',
    );
  }
}
