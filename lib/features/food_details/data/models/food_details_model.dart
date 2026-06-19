import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/data/models/customization_model.dart';

class FoodDetailsModel {
  final String id;
  final String name;
  final String image;
  final double basePrice;
  final String description;
  final double rating;
  final int reviewsCount;
  final String restaurantId;
  final String restaurantName;
  final int deliveryTimeMin;
  final int deliveryTimeMax;
  final List<AddonModel> addons;
  final List<CustomizationModel> customizations;

  FoodDetailsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.basePrice,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    required this.restaurantId,
    required this.restaurantName,
    required this.deliveryTimeMin,
    required this.deliveryTimeMax,
    required this.addons,
    required this.customizations,
  });

  factory FoodDetailsModel.fromJson(Map<String, dynamic> json) {
    return FoodDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] ?? 0,
      restaurantId: json['restaurantId'] ?? '',
      restaurantName: json['restaurantName'] ?? '',
      deliveryTimeMin: json['deliveryTimeMin'] ?? 0,
      deliveryTimeMax: json['deliveryTimeMax'] ?? 0,
      addons: (json['addons'] as List?)
              ?.map((e) => AddonModel.fromJson(e))
              .toList() ??
          [],
      customizations: (json['customizations'] as List?)
              ?.map((e) => CustomizationModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'basePrice': basePrice,
      'description': description,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'deliveryTimeMin': deliveryTimeMin,
      'deliveryTimeMax': deliveryTimeMax,
      'addons': addons.map((e) => e.toJson()).toList(),
      'customizations': customizations.map((e) => e.toJson()).toList(),
    };
  }

  FoodDetailsModel copyWith({
    String? id,
    String? name,
    String? image,
    double? basePrice,
    String? description,
    double? rating,
    int? reviewsCount,
    String? restaurantId,
    String? restaurantName,
    int? deliveryTimeMin,
    int? deliveryTimeMax,
    List<AddonModel>? addons,
    List<CustomizationModel>? customizations,
  }) {
    return FoodDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      basePrice: basePrice ?? this.basePrice,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      deliveryTimeMin: deliveryTimeMin ?? this.deliveryTimeMin,
      deliveryTimeMax: deliveryTimeMax ?? this.deliveryTimeMax,
      addons: addons ?? this.addons,
      customizations: customizations ?? this.customizations,
    );
  }

  factory FoodDetailsModel.fake() {
    return FoodDetailsModel(
      id: '0',
      name: 'Food Name Placeholder',
      image: '',
      basePrice: 0.0,
      description: 'Description placeholder for skeleton effect',
      rating: 0.0,
      reviewsCount: 0,
      restaurantId: '0',
      restaurantName: 'Restaurant Name',
      deliveryTimeMin: 0,
      deliveryTimeMax: 0,
      addons: [],
      customizations: [],
    );
  }
}
