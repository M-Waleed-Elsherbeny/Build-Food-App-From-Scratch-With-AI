import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';


class SearchResultModel {
  final String id;
  final String query;
  final List<RestaurantModel> restaurants;

  SearchResultModel({
    required this.id,
    required this.query,
    required this.restaurants,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id'] ?? '',
      query: json['query'] ?? '',
      restaurants: (json['restaurants'] as List<dynamic>?)
              ?.map((e) => RestaurantModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'query': query,
      'restaurants': restaurants.map((e) => e.toJson()).toList(),
    };
  }

  SearchResultModel copyWith({
    String? id,
    String? query,
    List<RestaurantModel>? restaurants,
  }) {
    return SearchResultModel(
      id: id ?? this.id,
      query: query ?? this.query,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
