import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/home_api_service.dart';
import '../models/category_model.dart';
import '../models/offer_model.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../models/food_model.dart';
import 'home_repository.dart';

/// Remote implementation of [HomeRepository] using live API.
/// This is prepared for future use but disabled by default.
class RemoteHomeRepository implements HomeRepository {
  final HomeApiService _apiService;

  RemoteHomeRepository(this._apiService);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _apiService.getCategories();
      final List data = response.data['categories'] ?? [];
      return Right(data.map((e) => CategoryModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RestaurantModel>>> getRestaurants({String? query}) async {
    try {
      final response = await _apiService.getRestaurants(
        queryParameters: query != null ? {'q': query} : null,
      );
      final List data = response.data['restaurants'] ?? [];
      return Right(data.map((e) => RestaurantModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers() async {
    try {
      final response = await _apiService.getOffers();
      final List data = response.data['offers'] ?? [];
      return Right(data.map((e) => OfferModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FoodModel>>> getMeals() async {
    try {
      final response = await _apiService.getMeals();
      final List data = response.data['meals'] ?? [];
      return Right(data.map((e) => FoodModel.fromJson(e)).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
