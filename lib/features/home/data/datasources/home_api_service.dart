import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';

class HomeApiService {
  final ApiClient _apiClient;

  HomeApiService(this._apiClient);

  /// Fetches all food categories.
  Future<Response> getCategories() async {
    return await _apiClient.get(AppEndpoints.categories);
  }

  /// Fetches all restaurants.
  Future<Response> getRestaurants({Map<String, dynamic>? queryParameters}) async {
    return await _apiClient.get(
      AppEndpoints.restaurants,
      queryParameters: queryParameters,
    );
  }

  /// Fetches active offers and banners.
  Future<Response> getOffers() async {
    return await _apiClient.get(AppEndpoints.offers);
  }

  /// Fetches recommended meals.
  Future<Response> getMeals() async {
    return await _apiClient.get(AppEndpoints.meals);
  }
}
