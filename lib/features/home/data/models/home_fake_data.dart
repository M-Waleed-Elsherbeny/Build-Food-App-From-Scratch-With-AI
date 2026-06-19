import '../models/category_model.dart';
import '../models/offer_model.dart';

class HomeFakeData {
  static List<CategoryModel> get categories => [
    CategoryModel(
      id: '1',
      name: 'Burgers',
      image: 'https://cdn-icons-png.flaticon.com/512/3075/3075977.png',
    ),
    CategoryModel(
      id: '2',
      name: 'Pizza',
      image: 'https://cdn-icons-png.flaticon.com/512/3595/3595455.png',
    ),
    CategoryModel(
      id: '3',
      name: 'Sushi',
      image: 'https://cdn-icons-png.flaticon.com/512/2252/2252438.png',
    ),
    CategoryModel(
      id: '4',
      name: 'Desserts',
      image: 'https://cdn-icons-png.flaticon.com/512/2515/2515183.png',
    ),
    CategoryModel(
      id: '5',
      name: 'Salad',
      image: 'https://cdn-icons-png.flaticon.com/512/2917/2917633.png',
    ),
  ];

  static List<OfferModel> get offers => [
    OfferModel(
      id: '1',
      title: '50% OFF',
      description: 'On your first order above \$20',
      image: '',
      code: 'WELCOME50',
    ),
    OfferModel(
      id: '2',
      title: 'Free Delivery',
      description: 'On all orders from selected restaurants',
      image: '',
      code: 'FREEDEL',
    ),
    OfferModel(
      id: '3',
      title: 'Buy 1 Get 1',
      description: 'Available on all pizzas every Friday',
      image: '',
      code: 'BOGOFRIDAY',
    ),
  ];
}
