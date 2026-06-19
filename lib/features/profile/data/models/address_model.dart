import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  final String id;
  final String title;
  final String fullAddress;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.title,
    required this.fullAddress,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      fullAddress: json['fullAddress'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fullAddress': fullAddress,
      'isDefault': isDefault,
    };
  }

  AddressModel copyWith({
    String? id,
    String? title,
    String? fullAddress,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [id, title, fullAddress, isDefault];
}
