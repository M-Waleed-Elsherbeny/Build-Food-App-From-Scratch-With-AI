import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/favorite_item_model.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<FavoriteItemModel>>> getFavorites();
  Future<Either<Failure, List<FavoriteItemModel>>> addFavorite(FavoriteItemModel item);
  Future<Either<Failure, List<FavoriteItemModel>>> removeFavorite(String itemId);
  Future<Either<Failure, bool>> isFavorite(String itemId);
}
