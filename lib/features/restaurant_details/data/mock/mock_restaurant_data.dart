import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';

import '../models/menu_category_model.dart';
import '../models/menu_item_model.dart';
import '../models/review_model.dart';

class MockRestaurantData {
  static final List<RestaurantModel> mockRestaurants = [
    RestaurantModel(
      id: '1',
      name: 'Burger King',
      imageUrl:
          'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500&auto=format&fit=crop',
      rating: 4.5,
      reviewsCount: 120,
      deliveryTime: '25-35 min',
      deliveryFee: 2.99,
      cuisine: 'Burgers, Fast Food',
      description:
          'Famous fast-food chain known for its grilled burgers, fries & shakes.',
      tags: ['Burgers', 'American', 'Fast Food'],
      isFavorite: false,
    ),
    RestaurantModel(
      id: '2',
      name: 'Pizza Hut',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&auto=format&fit=crop',
      description:
          'Classic pizza chain with a wide variety of pizzas, pastas & sides.',
      rating: 4.2,
      reviewsCount: 85,
      deliveryTime: '30-40 min',
      deliveryFee: 1.99,
      cuisine: 'Pizza, Italian',
      tags: ['Pizza', 'Italian', 'Fast Food'],
      isFavorite: false,
    ),
    RestaurantModel(
      id: '3',
      name: 'Sushi Zen',
      imageUrl:
          'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&auto=format&fit=crop',
      description:
          'Authentic Japanese cuisine featuring fresh sushi, sashimi & ramen.',
      rating: 4.8,
      reviewsCount: 210,
      deliveryTime: '40-50 min',
      deliveryFee: 4.99,
      cuisine: 'Sushi, Japanese',
      tags: ['Sushi', 'Japanese', 'Seafood'],
      isFavorite: false,
    ),
    RestaurantModel(
      id: '4',
      name: 'Taco Bell',
      imageUrl:
          'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&auto=format&fit=crop',
      description:
          'Popular Mexican fast-food chain known for its tacos, burritos & nachos.',
      rating: 4.0,
      reviewsCount: 150,
      deliveryTime: '20-30 min',
      deliveryFee: 0.99,
      cuisine: 'Mexican, Fast Food',
      tags: ['Mexican', 'Fast Food', 'Tacos'],
      isFavorite: false,
    ),
  ];

  static final List<MenuCategoryModel> categories = [
    MenuCategoryModel(id: '1', name: 'Popular'),
    MenuCategoryModel(id: '2', name: 'Burgers'),
    MenuCategoryModel(id: '3', name: 'Sides'),
    MenuCategoryModel(id: '4', name: 'Drinks'),
  ];

  static final List<MenuItemModel> menuItems = [
    MenuItemModel(
      id: '1',
      name: 'Classic Smash Burger',
      description:
          'Double beef patty, American cheese, lettuce, tomato, pickles, and our secret sauce.',
      price: 12.99,
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      rating: 4.9,
      calories: 850,
      categoryId: '2',
    ),
    MenuItemModel(
      id: '2',
      name: 'Spicy Chicken Sandwich',
      description:
          'Crispy fried chicken breast, spicy mayo, pickles on a brioche bun.',
      price: 10.99,
      image: 'https://images.unsplash.com/photo-1615719413546-198b25453f85',
      rating: 4.7,
      calories: 720,
      categoryId: '2',
    ),
    MenuItemModel(
      id: '3',
      name: 'Loaded Truffle Fries',
      description:
          'Shoestring fries topped with parmesan, truffle oil, and chives.',
      price: 6.99,
      image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877',
      rating: 4.8,
      calories: 540,
      categoryId: '3',
    ),
    MenuItemModel(
      id: '4',
      name: 'Onion Rings',
      description: 'Thick-cut, beer-battered onion rings with a side of ranch.',
      price: 5.99,
      image: 'https://images.unsplash.com/photo-1639024471283-0351e391b490',
      rating: 4.5,
      calories: 450,
      categoryId: '3',
    ),
    MenuItemModel(
      id: '5',
      name: 'Vanilla Milkshake',
      description: 'Classic hand-spun vanilla milkshake with whipped cream.',
      price: 4.99,
      image: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699',
      rating: 4.6,
      calories: 600,
      categoryId: '4',
    ),
    // Popular items (categoryId = '1')
    MenuItemModel(
      id: '1',
      name: 'Classic Smash Burger',
      description:
          'Double beef patty, American cheese, lettuce, tomato, pickles, and our secret sauce.',
      price: 12.99,
      image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
      rating: 4.9,
      calories: 850,
      categoryId: '1',
    ),
    MenuItemModel(
      id: '3',
      name: 'Loaded Truffle Fries',
      description:
          'Shoestring fries topped with parmesan, truffle oil, and chives.',
      price: 6.99,
      image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877',
      rating: 4.8,
      calories: 540,
      categoryId: '1',
    ),
  ];

  static final List<ReviewModel> reviews = [
    ReviewModel(
      id: '1',
      userName: 'Sarah Jenkins',
      userImage: 'https://i.pravatar.cc/150?u=sarah',
      rating: 5.0,
      comment:
          'Absolutely love the smash burgers here! The truffle fries are to die for.',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ReviewModel(
      id: '2',
      userName: 'Mike Ross',
      userImage: 'https://i.pravatar.cc/150?u=mike',
      rating: 4.0,
      comment: 'Great food, but delivery took a bit longer than expected.',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ReviewModel(
      id: '3',
      userName: 'Emily Chen',
      userImage: 'https://i.pravatar.cc/150?u=emily',
      rating: 5.0,
      comment: 'Best chicken sandwich I have had in a long time!',
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];
}
