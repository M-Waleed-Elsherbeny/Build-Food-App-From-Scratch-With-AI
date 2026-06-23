-- Enable UUID generation support
create extension if not exists pgcrypto;

-- Helper function to update updated_at timestamps
create or replace function set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Profiles (extends auth.users)
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  name text,
  avatar text,
  phone text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger profiles_set_updated_at
before update on public.profiles
for each row
execute function set_updated_at();

-- User addresses
create table if not exists public.addresses (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  title text not null,
  address_line text not null,
  is_default boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger addresses_set_updated_at
before update on public.addresses
for each row
execute function set_updated_at();

-- Restaurants
create table if not exists public.restaurants (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  image_url text,
  rating numeric not null default 0,
  reviews_count integer not null default 0,
  delivery_time text,
  delivery_fee numeric not null default 0,
  cuisine text,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger restaurants_set_updated_at
before update on public.restaurants
for each row
execute function set_updated_at();

-- Restaurant tags
create table if not exists public.restaurant_tags (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  tag text not null,
  created_at timestamptz not null default now()
);

-- Menu / food items
create table if not exists public.foods (
  id uuid primary key default gen_random_uuid(),
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  name text not null,
  image text,
  price numeric not null default 0,
  description text,
  rating numeric not null default 0,
  is_available boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger foods_set_updated_at
before update on public.foods
for each row
execute function set_updated_at();

-- Favorites
create table if not exists public.favorites (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  food_id uuid references public.foods(id) on delete cascade,
  restaurant_id uuid references public.restaurants(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (profile_id, food_id),
  unique (profile_id, restaurant_id)
);

-- Cart items
create table if not exists public.cart_items (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  food_id uuid not null references public.foods(id) on delete cascade,
  quantity integer not null default 1,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (profile_id, food_id)
);

create trigger cart_items_set_updated_at
before update on public.cart_items
for each row
execute function set_updated_at();

-- Orders
create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid not null references public.profiles(id) on delete cascade,
  restaurant_id uuid not null references public.restaurants(id) on delete cascade,
  address_id uuid references public.addresses(id) on delete set null,
  status text not null default 'pending',
  total_price numeric not null default 0,
  delivery_fee numeric not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger orders_set_updated_at
before update on public.orders
for each row
execute function set_updated_at();

-- Order items
create table if not exists public.order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  food_id uuid not null references public.foods(id) on delete restrict,
  name text not null,
  quantity integer not null default 1,
  unit_price numeric not null default 0,
  created_at timestamptz not null default now()
);

-- Order tracking
create table if not exists public.order_tracking (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  eta_minutes integer,
  status text not null,
  driver_name text,
  driver_phone text,
  driver_avatar text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger order_tracking_set_updated_at
before update on public.order_tracking
for each row
execute function set_updated_at();

-- Tracking timeline events
create table if not exists public.tracking_timeline (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.orders(id) on delete cascade,
  status text not null,
  message text,
  timestamp timestamptz not null default now()
);

-- Recommended indexes
create index if not exists idx_addresses_profile_id on public.addresses(profile_id);
create index if not exists idx_restaurant_tags_restaurant_id on public.restaurant_tags(restaurant_id);
create index if not exists idx_foods_restaurant_id on public.foods(restaurant_id);
create index if not exists idx_favorites_profile_id on public.favorites(profile_id);
create index if not exists idx_cart_items_profile_id on public.cart_items(profile_id);
create index if not exists idx_orders_profile_id on public.orders(profile_id);
create index if not exists idx_orders_status on public.orders(status);
create index if not exists idx_order_items_order_id on public.order_items(order_id);
create index if not exists idx_order_tracking_order_id on public.order_tracking(order_id);
create index if not exists idx_tracking_timeline_order_id on public.tracking_timeline(order_id);
