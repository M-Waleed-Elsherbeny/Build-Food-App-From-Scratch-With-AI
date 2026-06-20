class AddressModel {
  final String id;
  final String title;
  final String addressLine;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.title,
    required this.addressLine,
    this.isDefault = false,
  });

  /// Factory constructor to parse an [AddressModel] from JSON.
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      title: json['title'] as String,
      addressLine: json['addressLine'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  /// Converts this [AddressModel] to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'addressLine': addressLine,
      'isDefault': isDefault,
    };
  }

  /// Creates a copy of this [AddressModel] with the given fields replaced.
  AddressModel copyWith({
    String? id,
    String? title,
    String? addressLine,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      addressLine: addressLine ?? this.addressLine,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          addressLine == other.addressLine &&
          isDefault == other.isDefault;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ addressLine.hashCode ^ isDefault.hashCode;
}
