class FoodModel {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final double rating;
  final String restaurantId;
  final String restaurantName;

  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
    required this.restaurantId,
    required this.restaurantName,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      restaurantId: json['restaurantId'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'description': description,
      'rating': rating,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
    };
  }

  FoodModel copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    String? description,
    double? rating,
    String? restaurantId,
    String? restaurantName,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }

  factory FoodModel.fake() {
    return FoodModel(
      id: '0',
      name: 'Food Name Placeholder',
      image: '',
      price: 0.0,
      description: 'Description placeholder for skeleton effect',
      rating: 0.0,
      restaurantId: '0',
      restaurantName: 'Restaurant Name',
    );
  }
}
