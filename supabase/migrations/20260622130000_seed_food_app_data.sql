-- Seed sample data for restaurants, tags, and foods

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
    '11111111-1111-1111-1111-111111111111',
    'Burger King',
    'Famous fast-food chain known for its grilled burgers, fries & shakes.',
    'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500&auto=format&fit=crop',
    4.5,
    120,
    '25-35 min',
    2.99,
    'Burgers, Fast Food',
    true
  ),
  (
    '22222222-2222-2222-2222-222222222222',
    'Pizza Hut',
    'Classic pizza chain with a wide variety of pizzas, pastas & sides.',
    'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&auto=format&fit=crop',
    4.2,
    85,
    '30-40 min',
    1.99,
    'Pizza, Italian',
    true
  ),
  (
    '33333333-3333-3333-3333-333333333333',
    'Sushi Zen',
    'Authentic Japanese cuisine featuring fresh sushi, sashimi & ramen.',
    'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&auto=format&fit=crop',
    4.8,
    210,
    '40-50 min',
    4.99,
    'Sushi, Japanese',
    true
  ),
  (
    '44444444-4444-4444-4444-444444444444',
    'Taco Bell',
    'Popular Mexican fast-food chain known for its tacos, burritos & nachos.',
    'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500&auto=format&fit=crop',
    4.0,
    150,
    '20-30 min',
    0.99,
    'Mexican, Fast Food',
    true
  )
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.restaurant_tags (id, restaurant_id, tag) VALUES
  ('a1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'Burgers'),
  ('a2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'American'),
  ('a3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'Fast Food'),
  ('a4444444-4444-4444-4444-444444444444', '22222222-2222-2222-2222-222222222222', 'Pizza'),
  ('a5555555-5555-5555-5555-555555555555', '22222222-2222-2222-2222-222222222222', 'Italian'),
  ('a6666666-6666-6666-6666-666666666666', '22222222-2222-2222-2222-222222222222', 'Fast Food'),
  ('a7777777-7777-7777-7777-777777777777', '33333333-3333-3333-3333-333333333333', 'Sushi'),
  ('a8888888-8888-8888-8888-888888888888', '33333333-3333-3333-3333-333333333333', 'Japanese'),
  ('a9999999-9999-9999-9999-999999999999', '33333333-3333-3333-3333-333333333333', 'Seafood'),
  ('aa000000-0000-0000-0000-000000000000', '44444444-4444-4444-4444-444444444444', 'Mexican'),
  ('aa111111-1111-1111-1111-111111111111', '44444444-4444-4444-4444-444444444444', 'Fast Food'),
  ('aa222222-2222-2222-2222-222222222222', '44444444-4444-4444-4444-444444444444', 'Tacos')
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
    '51111111-1111-1111-1111-111111111111',
    '11111111-1111-1111-1111-111111111111',
    'Classic Smash Burger',
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
    12.99,
    'Double beef patty, American cheese, lettuce, tomato, pickles, and our secret sauce.',
    4.9,
    true
  ),
  (
    '52222222-2222-2222-2222-222222222222',
    '11111111-1111-1111-1111-111111111111',
    'Spicy Chicken Sandwich',
    'https://images.unsplash.com/photo-1615719413546-198b25453f85',
    10.99,
    'Crispy fried chicken breast, spicy mayo, pickles on a brioche bun.',
    4.7,
    true
  ),
  (
    '53333333-3333-3333-3333-333333333333',
    '22222222-2222-2222-2222-222222222222',
    'Pepperoni Pizza',
    'https://images.unsplash.com/photo-1628840042765-356cda07504e',
    14.99,
    'Classic pepperoni pizza with mozzarella cheese.',
    4.5,
    true
  ),
  (
    '54444444-4444-4444-4444-444444444444',
    '33333333-3333-3333-3333-333333333333',
    'Dragon Roll',
    'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351',
    18.99,
    'Sushi roll with eel, cucumber, and avocado topping.',
    4.9,
    true
  ),
  (
    '55555555-5555-5555-5555-555555555555',
    '44444444-4444-4444-4444-444444444444',
    'Crunchy Taco',
    'https://images.unsplash.com/photo-1552332386-f8dd00dc2f85',
    3.99,
    'Seasoned beef, lettuce, and cheese in a crunchy corn shell.',
    4.2,
    true
  ),
  (
    '56666666-6666-6666-6666-666666666666',
    '11111111-1111-1111-1111-111111111111',
    'Loaded Truffle Fries',
    'https://images.unsplash.com/photo-1573080496219-bb080dd4f877',
    6.99,
    'Shoestring fries topped with parmesan, truffle oil, and chives.',
    4.8,
    true
  )
ON CONFLICT (id) DO NOTHING;
