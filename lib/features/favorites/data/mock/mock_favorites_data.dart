import '../models/favorite_item_model.dart';

class MockFavoritesData {
  static final List<FavoriteItemModel> initialFavorites = [
    FavoriteItemModel(
      id: 'fav_1',
      name: 'Salmon Poke Bowl',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAmrKNTIlxoLMtsZSdFRHXCDahwfMOCdlIquZqONsufINicrk2AII_YMLC3RipHu6RLflaTgTHgVgGN86MHrxeMekv9kFs2ykBz8_T5qQqjq91_3tLnlVNRbyjtM2dwBnV4EqLokrkHPQzZzhn6Wn9ZetvNYXQ5PvJ_gYD8B6l1aibfGtXdSdKfSFRTtNBzF2DMLUBLJHftkVEdPc-K8ui7YW6WTx-3vE3jT5EO9J9kqcp8a-8eZGLXGUUpvGyd2piEw7cEsl7L4TKT',
      rating: 4.9,
      restaurantName: 'Zen Garden Kitchen',
      price: 18.50,
      isFavorite: true,
    ),
    FavoriteItemModel(
      id: 'fav_2',
      name: 'Truffle Margherita',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDtHGeRDPXya5Zdf6NihrY3X4u2eVweMK-Jft_MFn9J6qswdeeLTZaxSQl0A5QH4lgqJGgjOJFjp8ji4aUH1efcqM3pm2MA2WEAnFQxMm7pA56ECsQuUyukVh-JWcG_BKuepzFcaxvRmF6w3xc5FsjmEhH32QLBqwEGs3UuQmQpnk6OpRbI5e_OcGzCSoMfpyVJC2UFwn4jphCX0awn53A_QhPGEKYDTT3hQYRvdcnHnxo3RHwLWD7yxiEppBOMTZzbJH2Bnk9YqyOM',
      rating: 4.7,
      restaurantName: "Luigi's Artisan Pizza",
      price: 22.00,
      isFavorite: true,
    ),
    FavoriteItemModel(
      id: 'fav_3',
      name: 'Wagyu Signature',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC3x9t2dkaehyLCdGkKLGuxjGquE42IHnl15vq3CNsXKpy0VdQWc8TYPHiMLDGuWOG2Y3Hsv5WDI5EA1F04wzm7VsFrOa2AHxa3e8w0KHyuhsMqSOCozaHNREVt8aANrBQgskIHzrow4keLr2PT3afjv48VOSeuzA0FKvluSq4fwhJK0oioddf3fEhwJujQjRtqspCuHmJpZCC2EDaGeReU0PHsGKQvLwAkLpY6BdB5L16E4iT5RoIKW5osZRL26NknPvH3EuhD5dtd',
      rating: 4.8,
      restaurantName: 'The Burger Craft',
      price: 19.99,
      isFavorite: true,
    ),
    FavoriteItemModel(
      id: 'fav_4',
      name: 'Berry Honeycomb Stack',
      image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAukbdZokYfJPQWNi1QCa_8DGJGHcXzZ_2IYK3wxFzkPp6fWYz_47zB-oFN6rSVZYDKgO2mEhYVh8faV2Ah9Asem9VAw5kgp570xxIjzK4sLOArNPrGcpOSMWLFvNxNAivSbOhdhxg3IX14i4n8E0ZAzeSgnzPLVZDW6rB3qLGJxM8ETKu5X-0gPvxeiVGaxEP5RlC0zFlz5yTkUzzXSlpaiad1mVpBnpQUESY7nCB-1zxYHeGOhD6rlx-t1VZ89cPv5OjdjN3vQQBB',
      rating: 4.6,
      restaurantName: 'Morning Dew Bistro',
      price: 14.50,
      isFavorite: true,
    ),
  ];
}
