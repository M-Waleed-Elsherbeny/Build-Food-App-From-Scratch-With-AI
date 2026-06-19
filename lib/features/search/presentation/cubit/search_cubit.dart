import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/search_filter_model.dart';
import '../../data/repositories/search_repository.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;
  Timer? _debounceTimer;

  SearchCubit(this._repository) : super(const SearchState()) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    emit(state.copyWith(status: SearchStatus.loading));

    final trendingResult = await _repository.getTrendingSearches();
    final recentResult = await _repository.getRecentSearches();

    List<String> trending = [];
    List<String> recent = [];

    trendingResult.fold(
      (failure) => null,
      (data) => trending = data,
    );

    recentResult.fold(
      (failure) => null,
      (data) => recent = data,
    );

    emit(state.copyWith(
      status: SearchStatus.initial,
      trendingSearches: trending,
      recentSearches: recent,
    ));
  }

  void search(String query) {
    if (query.isEmpty) {
      _debounceTimer?.cancel();
      emit(state.copyWith(
        query: '',
        status: SearchStatus.initial, // When empty, we show recent/trending
        searchResult: null,
      ));
      return;
    }

    emit(state.copyWith(query: query));

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query, state.filter);
    });
  }

  Future<void> _performSearch(String query, SearchFilterModel filter) async {
    emit(state.copyWith(status: SearchStatus.loading));

    final result = await _repository.search(query, filter: filter);

    result.fold(
      (failure) => emit(state.copyWith(
        status: SearchStatus.failure,
        error: failure.message,
      )),
      (data) {
        emit(state.copyWith(
          status: SearchStatus.success,
          searchResult: data,
        ));
      },
    );
  }

  void submitSearch(String query) async {
    if (query.isEmpty) return;
    await _repository.saveRecentSearch(query);
    loadInitialData(); // reload recents
    
    // trigger immediate search
    _debounceTimer?.cancel();
    emit(state.copyWith(query: query));
    _performSearch(query, state.filter);
  }

  void applyFilter(SearchFilterModel newFilter) {
    emit(state.copyWith(filter: newFilter));
    if (state.query.isNotEmpty) {
      _performSearch(state.query, newFilter);
    }
  }

  void clearRecentSearches() async {
    await _repository.clearRecentSearches();
    loadInitialData();
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
