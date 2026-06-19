import 'package:dartz/dartz.dart';
import 'package:food_app/core/errors/failures.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';
import 'package:food_app/features/food_details/data/repositories/food_details_repository.dart';
import 'package:food_app/features/food_details/data/mock/mock_food_data.dart';

class FakeFoodDetailsRepository implements FoodDetailsRepository {
  @override
  Future<Either<Failure, FoodDetailsModel>> getFoodDetails(String id) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));
      
      return Right(MockFoodData.getFakeFood());
    } catch (e) {
      return Left(ServerFailure('Failed to fetch food details'));
    }
  }
}
