import '../models/food_model.dart';

final List<FoodModel> mockMeals = [
  FoodModel(
    id: '1',
    name: 'Classic Cheeseburger',
    image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&auto=format&fit=crop',
    price: 9.99,
    description: 'Juicy beef patty with melted cheese, lettuce, and tomato.',
    rating: 4.7,
    restaurantId: '1',
    restaurantName: 'Burger King',
  ),
  FoodModel(
    id: '2',
    name: 'Pepperoni Pizza',
    image: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500&auto=format&fit=crop',
    price: 14.99,
    description: 'Classic pepperoni pizza with mozzarella cheese.',
    rating: 4.5,
    restaurantId: '2',
    restaurantName: 'Pizza Hut',
  ),
  FoodModel(
    id: '3',
    name: 'Dragon Roll',
    image: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=500&auto=format&fit=crop',
    price: 18.99,
    description: 'Sushi roll with eel, cucumber, and avocado topping.',
    rating: 4.9,
    restaurantId: '3',
    restaurantName: 'Sushi Zen',
  ),
  FoodModel(
    id: '4',
    name: 'Crunchy Taco',
    image: 'https://images.unsplash.com/photo-1552332386-f8dd00dc2f85?w=500&auto=format&fit=crop',
    price: 3.99,
    description: 'Seasoned beef, lettuce, and cheese in a crunchy corn shell.',
    rating: 4.2,
    restaurantId: '4',
    restaurantName: 'Taco Bell',
  ),
];
