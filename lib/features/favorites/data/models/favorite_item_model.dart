class FavoriteItemModel {
  final String id;
  final String name;
  final String image;
  final double rating;
  final String restaurantName;
  final double price;
  final bool isFavorite;

  FavoriteItemModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.restaurantName,
    required this.price,
    this.isFavorite = true,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      restaurantName: json['restaurantName'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isFavorite: json['isFavorite'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'restaurantName': restaurantName,
      'price': price,
      'isFavorite': isFavorite,
    };
  }

  FavoriteItemModel copyWith({
    String? id,
    String? name,
    String? image,
    double? rating,
    String? restaurantName,
    double? price,
    bool? isFavorite,
  }) {
    return FavoriteItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      restaurantName: restaurantName ?? this.restaurantName,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory FavoriteItemModel.fake() {
    return FavoriteItemModel(
      id: '0',
      name: 'Salmon Poke Bowl',
      image: '',
      rating: 4.8,
      restaurantName: 'Zen Garden Kitchen',
      price: 18.50,
      isFavorite: true,
    );
  }
}
