import 'package:food_app/features/restaurant_details/data/mock/mock_restaurant_data.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';

class MockSearchData {
  static const List<String> trendingSearches = [
    'Burgers',
    'Pizza',
    'Sushi',
    'Healthy',
    'Desserts',
    'Shawarma',
  ];

  static List<String> recentSearches = [
    'KFC',
    'Taco Bell',
  ];

  static List<RestaurantModel> get allRestaurants => MockRestaurantData.mockRestaurants;

  static List<RestaurantModel> searchRestaurants(String query) {
    final lowerQuery = query.toLowerCase();
    return allRestaurants.where((restaurant) {
      final matchName = restaurant.name.toLowerCase().contains(lowerQuery);
      final matchCuisine = restaurant.cuisine.toLowerCase().contains(lowerQuery);
      final matchTags = restaurant.tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
      return matchName || matchCuisine || matchTags;
    }).toList();
  }
}
