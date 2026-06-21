import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/favorite_item_model.dart';
import '../../data/repositories/favorites_repository.dart';
import 'favorites_state.dart';

/// Cubit that manages the favorites feature state.
class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _repository;

  FavoritesCubit(this._repository) : super(const FavoritesState());

  /// Loads all favorites from the repository.
  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    final result = await _repository.getFavorites();
    result.fold(
      (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMsg: failure.message,
      )),
      (favorites) => emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
      )),
    );
  }

  /// Adds an item to favorites.
  Future<void> addFavorite(FavoriteItemModel item) async {
    final result = await _repository.addFavorite(item);
    result.fold(
      (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMsg: failure.message,
      )),
      (favorites) => emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
      )),
    );
  }

  /// Removes an item from favorites by [itemId].
  Future<void> removeFavorite(String itemId) async {
    final result = await _repository.removeFavorite(itemId);
    result.fold(
      (failure) => emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMsg: failure.message,
      )),
      (favorites) => emit(state.copyWith(
        status: FavoritesStatus.success,
        favorites: favorites,
      )),
    );
  }
}
