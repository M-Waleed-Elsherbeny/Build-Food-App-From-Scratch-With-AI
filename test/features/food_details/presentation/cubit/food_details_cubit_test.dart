import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_app/core/errors/failures.dart';
import 'package:food_app/features/cart/data/models/cart_item_model.dart';
import 'package:food_app/features/cart/data/repositories/cart_repository.dart';
import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';
import 'package:food_app/features/food_details/data/repositories/food_details_repository.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_cubit.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_state.dart';

class MockFoodDetailsRepository extends Mock implements FoodDetailsRepository {}
class MockCartRepository extends Mock implements CartRepository {}

void main() {
  late FoodDetailsRepository mockFoodDetailsRepository;
  late CartRepository mockCartRepository;
  late FoodDetailsCubit foodDetailsCubit;
  late FoodDetailsModel testFood;

  setUpAll(() {
    registerFallbackValue(const CartItemModel(
      id: '',
      name: '',
      price: 0.0,
      quantity: 1,
      imageUrl: '',
      restaurantName: '',
    ));
  });

  setUp(() {
    mockFoodDetailsRepository = MockFoodDetailsRepository();
    mockCartRepository = MockCartRepository();
    foodDetailsCubit = FoodDetailsCubit(mockFoodDetailsRepository, mockCartRepository);
    testFood = FoodDetailsModel.fake().copyWith(
      id: '1',
      name: 'Test Pizza',
      basePrice: 10.0,
      restaurantName: 'Test Pizzeria',
      addons: [
        AddonModel(id: '1', name: 'Cheese', price: 2.0),
      ],
    );
  });

  tearDown(() {
    foodDetailsCubit.close();
  });

  group('FoodDetailsCubit Tests', () {
    test('initial state has initial status and defaults', () {
      expect(foodDetailsCubit.state, const FoodDetailsState());
    });

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [loading, success] when loadFoodDetails succeeds',
      build: () {
        when(() => mockFoodDetailsRepository.getFoodDetails('1'))
            .thenAnswer((_) async => Right(testFood));
        return foodDetailsCubit;
      },
      act: (cubit) => cubit.loadFoodDetails('1'),
      expect: () => [
        const FoodDetailsState(status: FoodDetailsStatus.loading),
        FoodDetailsState(
          status: FoodDetailsStatus.success,
          food: testFood,
          selectedCustomizations: const {},
          isFavorite: false,
        ),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'emits [loading, failure] when loadFoodDetails fails',
      build: () {
        when(() => mockFoodDetailsRepository.getFoodDetails('1'))
            .thenAnswer((_) async => const Left(ServerFailure('Failed to load')));
        return foodDetailsCubit;
      },
      act: (cubit) => cubit.loadFoodDetails('1'),
      expect: () => [
        const FoodDetailsState(status: FoodDetailsStatus.loading),
        const FoodDetailsState(
          status: FoodDetailsStatus.failure,
          errorMsg: 'Failed to load',
        ),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'increments and decrements quantity correctly',
      build: () => foodDetailsCubit,
      act: (cubit) {
        cubit.incrementQuantity();
        cubit.decrementQuantity();
      },
      expect: () => [
        const FoodDetailsState(quantity: 2),
        const FoodDetailsState(quantity: 1),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'toggles addons and updates selectedAddons list',
      build: () => foodDetailsCubit,
      act: (cubit) {
        final addon = AddonModel(id: '1', name: 'Cheese', price: 2.0);
        cubit.toggleAddon(addon);
        cubit.toggleAddon(addon);
      },
      expect: () => [
        FoodDetailsState(selectedAddons: [AddonModel(id: '1', name: 'Cheese', price: 2.0)]),
        const FoodDetailsState(selectedAddons: []),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'toggles isFavorite successfully',
      build: () => foodDetailsCubit,
      act: (cubit) {
        cubit.toggleFavorite();
        cubit.toggleFavorite();
      },
      expect: () => [
        const FoodDetailsState(isFavorite: true),
        const FoodDetailsState(isFavorite: false),
      ],
    );

    blocTest<FoodDetailsCubit, FoodDetailsState>(
      'adds item to cart successfully and emits [loading, addToCartSuccess]',
      build: () {
        // First populate the state with loaded food details
        foodDetailsCubit.emit(FoodDetailsState(
          status: FoodDetailsStatus.success,
          food: testFood,
          quantity: 2,
        ));
        
        when(() => mockCartRepository.addItemToCart(any()))
            .thenAnswer((_) async => const Right([]));
            
        return foodDetailsCubit;
      },
      act: (cubit) => cubit.addToCart(),
      expect: () => [
        FoodDetailsState(
          status: FoodDetailsStatus.loading,
          food: testFood,
          quantity: 2,
        ),
        FoodDetailsState(
          status: FoodDetailsStatus.addToCartSuccess,
          food: testFood,
          quantity: 2,
        ),
      ],
    );
  });
}
