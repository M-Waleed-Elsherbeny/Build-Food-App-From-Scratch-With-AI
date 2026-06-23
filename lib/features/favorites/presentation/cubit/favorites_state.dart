import 'package:equatable/equatable.dart';
import '../../data/models/favorite_item_model.dart';

enum FavoritesStatus { initial, loading, loaded, favoriteAdded, favoriteRemoved, empty, error }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<FavoriteItemModel> favorites;
  final String errorMsg;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.errorMsg = '',
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<FavoriteItemModel>? favorites,
    String? errorMsg,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [status, favorites, errorMsg];
}

