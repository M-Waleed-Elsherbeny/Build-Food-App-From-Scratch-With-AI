class MenuCategoryModel {
  final String id;
  final String name;

  MenuCategoryModel({
    required this.id,
    required this.name,
  });

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return MenuCategoryModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  MenuCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return MenuCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory MenuCategoryModel.fake() {
    return MenuCategoryModel(
      id: '1',
      name: 'Burgers',
    );
  }
}
