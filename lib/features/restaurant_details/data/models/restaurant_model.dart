class RestaurantModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final String deliveryTime;
  final double deliveryFee;
  final List<String> tags;
  final bool isFavorite;
  final String cuisine;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.tags,
    required this.isFavorite,
    required this.cuisine,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] ?? 0,
      deliveryTime: json['deliveryTime'] ?? '',
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      tags: List<String>.from(json['tags']),
      isFavorite: json['isFavorite'] ?? false,
      cuisine: json['cuisine'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'tags': tags,
      'isFavorite': isFavorite,
      'cuisine': cuisine,
    };
  }

  RestaurantModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? rating,
    int? reviewsCount,
    String? deliveryTime,
    double? deliveryFee,
    List<String>? tags,
    bool? isFavorite,
    String? cuisine,
  }) {
    return RestaurantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      cuisine: cuisine ?? this.cuisine,
    );
  }

  factory RestaurantModel.fake() {
    return RestaurantModel(
      id: '1',
      name: 'Burger King',
      description: 'Famous fast-food chain known for its grilled burgers, fries & shakes.',
      imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349',
      rating: 4.5,
      reviewsCount: 1200,
      deliveryTime: '20-30 min',
      deliveryFee: 2.99,
      tags: ['Burgers', 'American', 'Fast Food'],
      isFavorite: false,
      cuisine: 'Fast Food',
    );
  }
}
