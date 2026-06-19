import '../models/offer_model.dart';

final List<OfferModel> mockOffers = [
  OfferModel(
    id: '1',
    title: '50% OFF',
    description: 'On your first order',
    image: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500&auto=format&fit=crop',
    code: 'WELCOME50',
  ),
  OfferModel(
    id: '2',
    title: 'Free Delivery',
    description: 'On orders above \$20',
    image: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&auto=format&fit=crop',
    code: 'FREESHIP',
  ),
  OfferModel(
    id: '3',
    title: 'Buy 1 Get 1',
    description: 'On selected sushi sets',
    image: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&auto=format&fit=crop',
    code: 'BOGOZEN',
  ),
];
