import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:food_app/core/errors/failures.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';
import 'package:food_app/features/food_details/data/repositories/food_details_repository.dart';

class RemoteFoodDetailsRepository implements FoodDetailsRepository {
  final Dio _dio;

  RemoteFoodDetailsRepository(this._dio);

  @override
  Future<Either<Failure, FoodDetailsModel>> getFoodDetails(String id) async {
    try {
      final response = await _dio.get('/api/food/$id');
      
      if (response.statusCode == 200) {
        return Right(FoodDetailsModel.fromJson(response.data));
      } else {
        return Left(ServerFailure('Failed to load food details'));
      }
    } on DioException catch (e) {
      // Note: ErrorHandler is expected to be used in real scenarios
      return Left(ServerFailure(e.message ?? 'Unknown Dio error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
