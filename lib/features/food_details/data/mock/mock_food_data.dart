import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/data/models/customization_model.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';

class MockFoodData {
  static final FoodDetailsModel margheritaPizza = FoodDetailsModel(
    id: '1',
    name: 'Margherita Pizza',
    image: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=500&auto=format&fit=crop', // Provide a real or placeholder URL
    basePrice: 15.0,
    description: 'Classic cheese pizza with authentic Italian tomato sauce and fresh basil. A perfect choice for cheese lovers looking for a traditional taste.',
    rating: 4.8,
    reviewsCount: 124,
    restaurantId: '1',
    restaurantName: 'Pizza Paradise',
    deliveryTimeMin: 20,
    deliveryTimeMax: 30,
    addons: [
      AddonModel(id: '1', name: 'Extra Cheese', price: 2.0),
      AddonModel(id: '2', name: 'Olives', price: 1.0),
      AddonModel(id: '3', name: 'Mushrooms', price: 1.5),
    ],
    customizations: [
      CustomizationModel(
        id: '1',
        title: 'Size',
        options: ['Small', 'Medium', 'Large'],
        isRequired: true,
      ),
    ],
  );

  static FoodDetailsModel getFakeFood() => margheritaPizza;
}
