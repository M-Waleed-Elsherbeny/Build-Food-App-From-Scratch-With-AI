import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/search_filter_model.dart';
import '../models/search_result_model.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchResultModel>> search(String query, {SearchFilterModel? filter});
  Future<Either<Failure, List<String>>> getTrendingSearches();
  Future<Either<Failure, List<String>>> getRecentSearches();
  Future<Either<Failure, void>> saveRecentSearch(String query);
  Future<Either<Failure, void>> clearRecentSearches();
}
