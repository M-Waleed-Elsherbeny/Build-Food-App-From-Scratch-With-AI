import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/api_client.dart';
import '../models/favorite_item_model.dart';
import 'favorites_repository.dart';

/// Remote implementation of [FavoritesRepository] using [ApiClient].
/// Prepared for future API integration.
class RemoteFavoritesRepository implements FavoritesRepository {
  final ApiClient _apiClient;

  RemoteFavoritesRepository(this._apiClient);

  @override
  Future<Either<Failure, List<FavoriteItemModel>>> getFavorites() async {
    try {
      // Future implementation:
      // final response = await _apiClient.get('/favorites');
      // return Right((response.data as List).map((x) => FavoriteItemModel.fromJson(x)).toList());
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteItemModel>>> addFavorite(FavoriteItemModel item) async {
    try {
      // Future implementation:
      // final response = await _apiClient.post('/favorites', data: item.toJson());
      // return Right((response.data as List).map((x) => FavoriteItemModel.fromJson(x)).toList());
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteItemModel>>> removeFavorite(String itemId) async {
    try {
      // Future implementation:
      // final response = await _apiClient.delete('/favorites/$itemId');
      // return Right((response.data as List).map((x) => FavoriteItemModel.fromJson(x)).toList());
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String itemId) async {
    try {
      // Future implementation:
      // final response = await _apiClient.get('/favorites/$itemId/status');
      // return Right(response.data['isFavorite'] ?? false);
      return const Left(ServerFailure('API not implemented yet. Using remote stub.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
