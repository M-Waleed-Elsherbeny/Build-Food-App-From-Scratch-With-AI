import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/data/repositories/food_details_repository.dart';
import 'package:food_app/features/cart/data/repositories/cart_repository.dart';
import 'package:food_app/features/cart/data/models/cart_item_model.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_state.dart';

class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  final FoodDetailsRepository _repository;
  final CartRepository _cartRepository;

  FoodDetailsCubit(this._repository, this._cartRepository) : super(const FoodDetailsState());

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
          isFavorite: false,
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

  void toggleFavorite() {
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  Future<void> addToCart() async {
    final food = state.food;
    if (food == null) return;

    emit(state.copyWith(status: FoodDetailsStatus.loading));

    final customText = state.selectedCustomizations.isNotEmpty
        ? ' (${state.selectedCustomizations.values.join(", ")})'
        : '';
    final addonsText = state.selectedAddons.isNotEmpty
        ? ' [Extra: ${state.selectedAddons.map((e) => e.name).join(", ")}]'
        : '';

    final customizationsHash = state.selectedCustomizations.entries.map((e) => '${e.key}:${e.value}').join('_');
    final addonsHash = state.selectedAddons.map((e) => e.id).join('_');
    final uniqueItemId = '${food.id}_${customizationsHash}_$addonsHash';

    final cartItem = CartItemModel(
      id: uniqueItemId,
      name: '${food.name}$customText$addonsText',
      price: state.totalPrice / state.quantity,
      quantity: state.quantity,
      imageUrl: food.image,
      restaurantName: food.restaurantName,
    );

    final result = await _cartRepository.addItemToCart(cartItem);

    result.fold(
      (failure) => emit(state.copyWith(
        status: FoodDetailsStatus.failure,
        errorMsg: failure.message,
      )),
      (_) => emit(state.copyWith(status: FoodDetailsStatus.addToCartSuccess)),
    );
  }
}
