import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../models/search_filter_model.dart';
import '../models/search_result_model.dart';
import 'search_repository.dart';

class RemoteSearchRepository implements SearchRepository {
  final Dio _dio;

  RemoteSearchRepository(this._dio);

  @override
  Future<Either<Failure, SearchResultModel>> search(String query, {SearchFilterModel? filter}) async {
    try {
      // final response = await _dio.get(
      //   '/api/v1/search', 
      //   queryParameters: {
      //     'q': query,
      //     'sortBy': filter?.sortBy.name,
      //     'minRating': filter?.minRating,
      //     'maxDeliveryFee': filter?.maxDeliveryFee,
      //   },
      // );
      // return Right(SearchResultModel.fromJson(response.data['data']));
      throw UnimplementedError('Remote backend not yet connected');
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTrendingSearches() async {
    try {
      // final response = await _dio.get('/api/v1/search/trending');
      // return Right(List<String>.from(response.data['data']));
      throw UnimplementedError();
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    // Recent searches are typically handled locally by LocalStorage / Cache
    throw UnimplementedError('Handled locally');
  }

  @override
  Future<Either<Failure, void>> saveRecentSearch(String query) async {
    throw UnimplementedError('Handled locally');
  }

  @override
  Future<Either<Failure, void>> clearRecentSearches() async {
    throw UnimplementedError('Handled locally');
  }
}
