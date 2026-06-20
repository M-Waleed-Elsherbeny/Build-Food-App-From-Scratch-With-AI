import 'package:equatable/equatable.dart';

class CustomizationModel extends Equatable {
  final String id;
  final String title;
  final List<String> options;
  final bool isRequired;

  const CustomizationModel({
    required this.id,
    required this.title,
    required this.options,
    this.isRequired = false,
  });

  factory CustomizationModel.fromJson(Map<String, dynamic> json) {
    return CustomizationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      isRequired: json['isRequired'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'options': options,
      'isRequired': isRequired,
    };
  }

  CustomizationModel copyWith({
    String? id,
    String? title,
    List<String>? options,
    bool? isRequired,
  }) {
    return CustomizationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      options: options ?? this.options,
      isRequired: isRequired ?? this.isRequired,
    );
  }

  @override
  List<Object?> get props => [id, title, options, isRequired];
}