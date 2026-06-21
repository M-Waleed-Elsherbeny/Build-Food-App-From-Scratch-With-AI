import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_favorites_data.dart';
import '../models/favorite_item_model.dart';
import 'favorites_repository.dart';

class FakeFavoritesRepository implements FavoritesRepository {
  final SharedPreferences _prefs;
  static const String _favoritesKey = 'user_favorites_key';

  FakeFavoritesRepository(this._prefs);

  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  List<FavoriteItemModel> _loadLocalFavorites()  {
    final List<String>? serialized = _prefs.getStringList(_favoritesKey);
    if (serialized == null) {
      // If no local favorites stored yet, initialize with MockFavoritesData
      final initial = MockFavoritesData.initialFavorites;
      _saveLocalFavorites(initial);
      return initial;
    }
    return serialized
        .map((item) => FavoriteItemModel.fromJson(json.decode(item)))
        .toList();
  }

  Future<void> _saveLocalFavorites(List<FavoriteItemModel> list) async {
    final List<String> serialized =
        list.map((item) => json.encode(item.toJson())).toList();
    await _prefs.setStringList(_favoritesKey, serialized);
  }

  @override
  Future<Either<Failure, List<FavoriteItemModel>>> getFavorites() async {
    try {
      await _delay();
      final favorites = _loadLocalFavorites();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteItemModel>>> addFavorite(FavoriteItemModel item) async {
    try {
      await _delay();
      final favorites = _loadLocalFavorites();
      if (!favorites.any((element) => element.id == item.id)) {
        favorites.add(item.copyWith(isFavorite: true));
        await _saveLocalFavorites(favorites);
      }
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteItemModel>>> removeFavorite(String itemId) async {
    try {
      await _delay();
      final favorites = _loadLocalFavorites();
      favorites.removeWhere((element) => element.id == itemId);
      await _saveLocalFavorites(favorites);
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String itemId) async {
    try {
      final favorites = _loadLocalFavorites();
      final exists = favorites.any((element) => element.id == itemId);
      return Right(exists);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
