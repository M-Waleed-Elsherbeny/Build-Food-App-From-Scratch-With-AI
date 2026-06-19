import 'package:equatable/equatable.dart';
import '../../data/models/search_filter_model.dart';
import '../../data/models/search_result_model.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final String query;
  final SearchResultModel? searchResult;
  final List<String> trendingSearches;
  final List<String> recentSearches;
  final SearchFilterModel filter;
  final String? error;

  const SearchState({
    this.status = SearchStatus.initial,
    this.query = '',
    this.searchResult,
    this.trendingSearches = const [],
    this.recentSearches = const [],
    this.filter = const SearchFilterModel(),
    this.error,
  });

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    SearchResultModel? searchResult,
    List<String>? trendingSearches,
    List<String>? recentSearches,
    SearchFilterModel? filter,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      searchResult: searchResult ?? this.searchResult,
      trendingSearches: trendingSearches ?? this.trendingSearches,
      recentSearches: recentSearches ?? this.recentSearches,
      filter: filter ?? this.filter,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        query,
        searchResult,
        trendingSearches,
        recentSearches,
        filter,
        error,
      ];
}
