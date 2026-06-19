import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/data/repositories/food_details_repository.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_state.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final FoodDetailsRepository _repository;

  FoodDetailsCubit(this._repository) : super(const FoodDetailsState());

  Future<void> loadFoodDetails(String id) async {
    emit(state.copyWith(status: FoodDetailsStatus.loading));

    final result = await _repository.getFoodDetails(id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: FoodDetailsStatus.failure,
        errorMsg: failure.message,
      )),
      (food) {
        // Pre-select first options for required customizations
        final initialCustomizations = <String, String>{};
        for (var custom in food.customizations) {
          if (custom.isRequired && custom.options.isNotEmpty) {
            initialCustomizations[custom.id] = custom.options.first;
          }
        }

        emit(state.copyWith(
          status: FoodDetailsStatus.success,
          food: food,
          selectedCustomizations: initialCustomizations,
        ));
      },
    );
  }

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  void toggleAddon(AddonModel addon) {
    final currentAddons = List<AddonModel>.from(state.selectedAddons);
    if (currentAddons.any((e) => e.id == addon.id)) {
      currentAddons.removeWhere((e) => e.id == addon.id);
    } else {
      currentAddons.add(addon);
    }
    emit(state.copyWith(selectedAddons: currentAddons));
  }

  void selectCustomization(String customizationId, String option) {
    final currentCustomizations = Map<String, String>.from(state.selectedCustomizations);
    currentCustomizations[customizationId] = option;
    emit(state.copyWith(selectedCustomizations: currentCustomizations));
  }

  void addToCart() {
    // Note: In a real implementation, this would call CartCubit or CartRepository
    // to add the item with current selected options and quantity to the cart.
    // For now, we can just print or emit a temporary status if needed.
  }
}
