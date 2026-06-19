import 'package:equatable/equatable.dart';

enum SortOption { relevance, rating, deliveryTime, popularity }

class SearchFilterModel extends Equatable {
  final SortOption sortBy;
  final double? maxDeliveryFee;
  final double? minRating;

  const SearchFilterModel({
    this.sortBy = SortOption.relevance,
    this.maxDeliveryFee,
    this.minRating,
  });

  SearchFilterModel copyWith({
    SortOption? sortBy,
    double? maxDeliveryFee,
    double? minRating,
  }) {
    return SearchFilterModel(
      sortBy: sortBy ?? this.sortBy,
      maxDeliveryFee: maxDeliveryFee ?? this.maxDeliveryFee,
      minRating: minRating ?? this.minRating,
    );
  }

  @override
  List<Object?> get props => [sortBy, maxDeliveryFee, minRating];
}
