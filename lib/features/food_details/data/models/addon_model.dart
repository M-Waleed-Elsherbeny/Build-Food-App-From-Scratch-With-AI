import 'package:equatable/equatable.dart';

class AddonModel extends Equatable {
  final String id;
  final String name;
  final double price;

  const AddonModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  AddonModel copyWith({
    String? id,
    String? name,
    double? price,
  }) {
    return AddonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  @override
  List<Object?> get props => [id, name, price];
}

