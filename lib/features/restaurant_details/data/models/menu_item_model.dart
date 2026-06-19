class MenuItemModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int calories;
  final String categoryId;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.calories,
    required this.categoryId,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      rating: (json['rating'] as num).toDouble(),
      calories: json['calories'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating,
      'calories': calories,
      'categoryId': categoryId,
    };
  }

  MenuItemModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? image,
    double? rating,
    int? calories,
    String? categoryId,
  }) {
    return MenuItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      calories: calories ?? this.calories,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  factory MenuItemModel.fake() {
    return MenuItemModel(
      id: '1',
      name: 'Classic Burger',
      description: 'Juicy beef patty with fresh lettuce, tomato, and our secret sauce.',
      price: 12.99,
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      rating: 4.8,
      calories: 550,
      categoryId: '1',
    );
  }
}
