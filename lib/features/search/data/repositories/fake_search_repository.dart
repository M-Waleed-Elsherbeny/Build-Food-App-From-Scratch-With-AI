import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_search_data.dart';
import '../models/search_filter_model.dart';
import '../models/search_result_model.dart';
import 'search_repository.dart';

class FakeSearchRepository implements SearchRepository {
  final SharedPreferences _prefs;
  static const String _recentSearchesKey = 'recent_searches_key';

  FakeSearchRepository(this._prefs);

  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<Either<Failure, SearchResultModel>> search(String query, {SearchFilterModel? filter}) async {
    try {
      await _delay();
      var results = MockSearchData.searchRestaurants(query);

      if (filter != null) {
        if (filter.minRating != null) {
          results = results.where((r) => r.rating >= filter.minRating!).toList();
        }
        if (filter.maxDeliveryFee != null) {
          results = results.where((r) => r.deliveryFee <= filter.maxDeliveryFee!).toList();
        }

        switch (filter.sortBy) {
          case SortOption.rating:
            results.sort((a, b) => b.rating.compareTo(a.rating));
            break;
          case SortOption.popularity:
            results.sort((a, b) => b.reviewsCount.compareTo(a.reviewsCount));
            break;
          case SortOption.deliveryTime:
            // Simplified sorting for mock
            results.sort((a, b) => a.deliveryTime.compareTo(b.deliveryTime));
            break;
          case SortOption.relevance:
            break;
        }
      }

      return Right(SearchResultModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        query: query,
        restaurants: results,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getTrendingSearches() async {
    try {
      await _delay();
      return Right(MockSearchData.trendingSearches);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getRecentSearches() async {
    try {
      final List<String>? recents = _prefs.getStringList(_recentSearchesKey);
      return Right(recents ?? MockSearchData.recentSearches);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveRecentSearch(String query) async {
    try {
      final List<String> recents = _prefs.getStringList(_recentSearchesKey) ?? MockSearchData.recentSearches;
      
      if (recents.contains(query)) {
        recents.remove(query);
      }
      recents.insert(0, query);
      
      if (recents.length > 10) {
        recents.removeLast();
      }
      
      await _prefs.setStringList(_recentSearchesKey, recents);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearRecentSearches() async {
    try {
      await _prefs.remove(_recentSearchesKey);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
