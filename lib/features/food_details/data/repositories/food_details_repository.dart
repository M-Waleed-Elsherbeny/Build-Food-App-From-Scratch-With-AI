import 'package:dartz/dartz.dart';
import 'package:food_app/core/errors/failures.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';

abstract class FoodDetailsRepository {
  Future<Either<Failure, FoodDetailsModel>> getFoodDetails(String id);
}
