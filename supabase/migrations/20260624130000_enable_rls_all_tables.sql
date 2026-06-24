-- Enable RLS on all remaining tables and create appropriate policies

-- ==========================================
-- 1. ADDRESSES (user-specific via profile_id)
-- ==========================================
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own addresses" ON public.addresses;
CREATE POLICY "Users can select own addresses" ON public.addresses
  FOR SELECT USING (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can insert own addresses" ON public.addresses;
CREATE POLICY "Users can insert own addresses" ON public.addresses
  FOR INSERT WITH CHECK (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can update own addresses" ON public.addresses;
CREATE POLICY "Users can update own addresses" ON public.addresses
  FOR UPDATE USING (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can delete own addresses" ON public.addresses;
CREATE POLICY "Users can delete own addresses" ON public.addresses
  FOR DELETE USING (auth.uid() = profile_id);

-- ==========================================
-- 2. RESTAURANTS (public read-only)
-- ==========================================
ALTER TABLE public.restaurants ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view restaurants" ON public.restaurants;
CREATE POLICY "Anyone can view restaurants" ON public.restaurants
  FOR SELECT USING (true);

-- ==========================================
-- 3. RESTAURANT_TAGS (public read-only)
-- ==========================================
ALTER TABLE public.restaurant_tags ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view restaurant tags" ON public.restaurant_tags;
CREATE POLICY "Anyone can view restaurant tags" ON public.restaurant_tags
  FOR SELECT USING (true);

-- ==========================================
-- 4. FOODS (public read-only)
-- ==========================================
ALTER TABLE public.foods ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view foods" ON public.foods;
CREATE POLICY "Anyone can view foods" ON public.foods
  FOR SELECT USING (true);

-- ==========================================
-- 5. FAVORITES (user-specific via profile_id)
-- ==========================================
ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own favorites" ON public.favorites;
CREATE POLICY "Users can select own favorites" ON public.favorites
  FOR SELECT USING (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can insert own favorites" ON public.favorites;
CREATE POLICY "Users can insert own favorites" ON public.favorites
  FOR INSERT WITH CHECK (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can delete own favorites" ON public.favorites;
CREATE POLICY "Users can delete own favorites" ON public.favorites
  FOR DELETE USING (auth.uid() = profile_id);

-- ==========================================
-- 6. CART_ITEMS (user-specific via profile_id)
-- ==========================================
ALTER TABLE public.cart_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own cart items" ON public.cart_items;
CREATE POLICY "Users can select own cart items" ON public.cart_items
  FOR SELECT USING (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can insert own cart items" ON public.cart_items;
CREATE POLICY "Users can insert own cart items" ON public.cart_items
  FOR INSERT WITH CHECK (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can update own cart items" ON public.cart_items;
CREATE POLICY "Users can update own cart items" ON public.cart_items
  FOR UPDATE USING (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can delete own cart items" ON public.cart_items;
CREATE POLICY "Users can delete own cart items" ON public.cart_items
  FOR DELETE USING (auth.uid() = profile_id);

-- ==========================================
-- 7. ORDERS (user-specific via profile_id)
-- ==========================================
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own orders" ON public.orders;
CREATE POLICY "Users can select own orders" ON public.orders
  FOR SELECT USING (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can insert own orders" ON public.orders;
CREATE POLICY "Users can insert own orders" ON public.orders
  FOR INSERT WITH CHECK (auth.uid() = profile_id);

DROP POLICY IF EXISTS "Users can update own orders" ON public.orders;
CREATE POLICY "Users can update own orders" ON public.orders
  FOR UPDATE USING (auth.uid() = profile_id);

-- ==========================================
-- 8. ORDER_ITEMS (user access via orders join)
-- ==========================================
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own order items" ON public.order_items;
CREATE POLICY "Users can select own order items" ON public.order_items
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.orders
      WHERE orders.id = order_items.order_id
        AND orders.profile_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can insert own order items" ON public.order_items;
CREATE POLICY "Users can insert own order items" ON public.order_items
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.orders
      WHERE orders.id = order_items.order_id
        AND orders.profile_id = auth.uid()
    )
  );

-- ==========================================
-- 9. ORDER_TRACKING (user access via orders join)
-- ==========================================
ALTER TABLE public.order_tracking ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own order tracking" ON public.order_tracking;
CREATE POLICY "Users can select own order tracking" ON public.order_tracking
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.orders
      WHERE orders.id = order_tracking.order_id
        AND orders.profile_id = auth.uid()
    )
  );

-- ==========================================
-- 10. TRACKING_TIMELINE (user access via orders join)
-- ==========================================
ALTER TABLE public.tracking_timeline ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can select own tracking timeline" ON public.tracking_timeline;
CREATE POLICY "Users can select own tracking timeline" ON public.tracking_timeline
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.orders
      WHERE orders.id = tracking_timeline.order_id
        AND orders.profile_id = auth.uid()
    )
  );
