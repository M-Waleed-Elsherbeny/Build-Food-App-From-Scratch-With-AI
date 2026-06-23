-- Seed additional restaurants, tags, and foods for richer app data

INSERT INTO public.restaurants (
  id,
  name,
  description,
  image_url,
  rating,
  reviews_count,
  delivery_time,
  delivery_fee,
  cuisine,
  is_active
) VALUES
  (
    '55555555-5555-5555-5555-555555555555',
    'KFC',
    'Crispy fried chicken favorites with classic sides and sauces.',
    'https://images.unsplash.com/photo-1562967914-608f82629710?w=500&auto=format&fit=crop',
    4.3,
    176,
    '20-30 min',
    1.49,
    'Chicken, Fast Food',
    true
  ),
  (
    '66666666-6666-6666-6666-666666666666',
    'Subway',
    'Freshly baked subs, salads, and healthy wraps made to order.',
    'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=500&auto=format&fit=crop',
    4.1,
    98,
    '15-25 min',
    0.99,
    'Sandwiches, Healthy',
    true
  ),
  (
    '77777777-7777-7777-7777-777777777777',
    'Pasta House',
    'Comfort Italian pasta dishes with homemade sauces and fresh ingredients.',
    'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=500&auto=format&fit=crop',
    4.7,
    143,
    '35-45 min',
    3.49,
    'Pasta, Italian',
    true
  ),
  (
    '88888888-8888-8888-8888-888888888888',
    'Mamma Mia',
    'Authentic Italian pizza and pasta served with a cozy neighborhood feel.',
    'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=500&auto=format&fit=crop',
    4.6,
    201,
    '30-40 min',
    2.49,
    'Pizza, Italian',
    true
  ),
  (
    '99999999-9999-9999-9999-999999999999',
    'Shake House',
    'Refreshing smoothies, shakes, and sweet treats for every craving.',
    'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500&auto=format&fit=crop',
    4.4,
    112,
    '10-20 min',
    0.79,
    'Drinks, Desserts',
    true
  ),
  (
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Green Bowl',
    'Healthy bowls, salads, and vegan-friendly meals for a fresh lifestyle.',
    'https://images.unsplash.com/photo-1543353071-873f17a7a088?w=500&auto=format&fit=crop',
    4.5,
    134,
    '15-25 min',
    1.99,
    'Healthy, Vegan',
    true
  )
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.restaurant_tags (id, restaurant_id, tag) VALUES
  ('b1111111-1111-1111-1111-111111111111', '55555555-5555-5555-5555-555555555555', 'Chicken'),
  ('b2222222-2222-2222-2222-222222222222', '55555555-5555-5555-5555-555555555555', 'Fast Food'),
  ('b3333333-3333-3333-3333-333333333333', '66666666-6666-6666-6666-666666666666', 'Healthy'),
  ('b4444444-4444-4444-4444-444444444444', '66666666-6666-6666-6666-666666666666', 'Sandwiches'),
  ('b5555555-5555-5555-5555-555555555555', '77777777-7777-7777-7777-777777777777', 'Pasta'),
  ('b6666666-6666-6666-6666-666666666666', '77777777-7777-7777-7777-777777777777', 'Italian'),
  ('b7777777-7777-7777-7777-777777777777', '88888888-8888-8888-8888-888888888888', 'Pizza'),
  ('b8888888-8888-8888-8888-888888888888', '88888888-8888-8888-8888-888888888888', 'Italian'),
  ('b9999999-9999-9999-9999-999999999999', '99999999-9999-9999-9999-999999999999', 'Drinks'),
  ('ba000000-0000-0000-0000-000000000000', '99999999-9999-9999-9999-999999999999', 'Desserts'),
  ('ba111111-1111-1111-1111-111111111111', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Healthy'),
  ('ba222222-2222-2222-2222-222222222222', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Vegan')
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.foods (
  id,
  restaurant_id,
  name,
  image,
  price,
  description,
  rating,
  is_available
) VALUES
  (
    '57777777-7777-7777-7777-777777777777',
    '55555555-5555-5555-5555-555555555555',
    'Original Recipe Bucket',
    'https://images.unsplash.com/photo-1544025162-d76694265947',
    19.99,
    'A crispy chicken bucket with signature seasoning and hot wings.',
    4.6,
    true
  ),
  (
    '58888888-8888-8888-8888-888888888888',
    '55555555-5555-5555-5555-555555555555',
    'Chicken Wrap',
    'https://images.unsplash.com/photo-1626700051175-6818013e1d4f',
    7.49,
    'Tender chicken wrapped in a soft tortilla with fresh lettuce and sauce.',
    4.2,
    true
  ),
  (
    '59999999-9999-9999-9999-999999999999',
    '66666666-6666-6666-6666-666666666666',
    'Italian BMT',
    'https://images.unsplash.com/photo-1528735602780-2552fd46c7af',
    8.99,
    'Loaded with salami, ham, and fresh veggies on toasted bread.',
    4.3,
    true
  ),
  (
    '5aaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    '66666666-6666-6666-6666-666666666666',
    'Veggie Delight',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe',
    6.99,
    'A colorful sandwich packed with lettuce, tomatoes, cucumbers, and olives.',
    4.4,
    true
  ),
  (
    '5bbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    '77777777-7777-7777-7777-777777777777',
    'Creamy Chicken Alfredo',
    'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9',
    15.49,
    'Pasta tossed in creamy parmesan sauce with grilled chicken.',
    4.8,
    true
  ),
  (
    '5ccccccc-cccc-cccc-cccc-cccccccccccc',
    '77777777-7777-7777-7777-777777777777',
    'Spicy Arrabbiata',
    'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9',
    12.99,
    'Tomato-based pasta with chili flakes and garlic.',
    4.5,
    true
  ),
  (
    '5ddddddd-dddd-dddd-dddd-dddddddddddd',
    '88888888-8888-8888-8888-888888888888',
    'Margherita Pizza',
    'https://images.unsplash.com/photo-1513104890138-7c749659a591',
    13.99,
    'Classic pizza with fresh tomato sauce, mozzarella, and basil.',
    4.7,
    true
  ),
  (
    '5eeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
    '88888888-8888-8888-8888-888888888888',
    'Four Cheese Pizza',
    'https://images.unsplash.com/photo-1513104890138-7c749659a591',
    16.49,
    'A rich combination of mozzarella, parmesan, cheddar, and gouda.',
    4.9,
    true
  ),
  (
    '5fffffff-ffff-ffff-ffff-ffffffffffff',
    '99999999-9999-9999-9999-999999999999',
    'Chocolate Shake',
    'https://images.unsplash.com/photo-1572490122747-3968b75cc699',
    5.49,
    'Creamy chocolate shake topped with whipped cream.',
    4.6,
    true
  ),
  (
    '60000000-0000-0000-0000-000000000000',
    '99999999-9999-9999-9999-999999999999',
    'Berry Smoothie',
    'https://images.unsplash.com/photo-1497534446932-c925b458314e',
    4.99,
    'A refreshing blend of strawberries, blueberries, and yogurt.',
    4.5,
    true
  ),
  (
    '61111111-1111-1111-1111-111111111111',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Avocado Bowl',
    'https://images.unsplash.com/photo-1543353071-873f17a7a088',
    9.99,
    'A fresh bowl with quinoa, avocado, greens, and roasted vegetables.',
    4.7,
    true
  ),
  (
    '62222222-2222-2222-2222-222222222222',
    'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    'Garden Salad',
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
    7.49,
    'Mixed greens with seasonal vegetables and light vinaigrette.',
    4.3,
    true
  )
ON CONFLICT (id) DO NOTHING;
