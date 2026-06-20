import 'package:equatable/equatable.dart';
import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';

enum FoodDetailsStatus { initial, loading, success, failure, addToCartSuccess }

class FoodDetailsState extends Equatable {
  final FoodDetailsStatus status;
  final FoodDetailsModel? food;
  final String errorMsg;
  final int quantity;
  final List<AddonModel> selectedAddons;
  final Map<String, String> selectedCustomizations;
  final bool isFavorite;

  const FoodDetailsState({
    this.status = FoodDetailsStatus.initial,
    this.food,
    this.errorMsg = '',
    this.quantity = 1,
    this.selectedAddons = const [],
    this.selectedCustomizations = const {},
    this.isFavorite = false,
  });

  double get totalPrice {
    if (food == null) return 0.0;
    double addonsPrice = selectedAddons.fold(0, (sum, addon) => sum + addon.price);
    return (food!.basePrice + addonsPrice) * quantity;
  }

  FoodDetailsState copyWith({
    FoodDetailsStatus? status,
    FoodDetailsModel? food,
    String? errorMsg,
    int? quantity,
    List<AddonModel>? selectedAddons,
    Map<String, String>? selectedCustomizations,
    bool? isFavorite,
  }) {
    return FoodDetailsState(
      status: status ?? this.status,
      food: food ?? this.food,
      errorMsg: errorMsg ?? this.errorMsg,
      quantity: quantity ?? this.quantity,
      selectedAddons: selectedAddons ?? this.selectedAddons,
      selectedCustomizations: selectedCustomizations ?? this.selectedCustomizations,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        status,
        food,
        errorMsg,
        quantity,
        selectedAddons,
        selectedCustomizations,
        isFavorite,
      ];
}
