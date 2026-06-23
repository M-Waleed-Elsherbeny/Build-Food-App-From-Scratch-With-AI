import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/api_client.dart';
import '../../features/onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../features/onboarding/data/repositories/onboarding_repository.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/auth/data/datasources/auth_api_service.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/fake_auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasources/home_api_service.dart';
import '../../features/home/data/repositories/home_repository.dart';
import '../../features/home/data/repositories/fake_home_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/restaurant_details/data/repositories/restaurant_repository.dart';
import '../../features/restaurant_details/data/repositories/fake_restaurant_repository.dart';
import '../../features/restaurant_details/presentation/cubit/restaurant_details_cubit.dart';
import '../../features/search/data/repositories/search_repository.dart';
import '../../features/search/data/repositories/fake_search_repository.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';
import '../../features/settings/data/repositories/settings_repository.dart';
import '../../features/settings/data/repositories/fake_settings_repository.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/cart/data/repositories/cart_repository.dart';
import '../../features/cart/data/repositories/fake_cart_repository.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/profile/data/repositories/profile_repository.dart';
import '../../features/profile/data/repositories/fake_profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/food_details/data/repositories/food_details_repository.dart';
import '../../features/food_details/data/repositories/fake_food_details_repository.dart';
import '../../features/food_details/presentation/cubit/food_details_cubit.dart';
import '../../features/favorites/data/repositories/favorites_repository.dart';
import '../../features/favorites/data/repositories/fake_favorites_repository.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/order_tracking/data/repositories/order_tracking_repository.dart';
import '../../features/order_tracking/data/repositories/fake_order_tracking_repository.dart';
import '../../features/order_tracking/presentation/cubit/order_tracking_cubit.dart';
import '../../features/order_history/data/repositories/order_history_repository.dart';
import '../../features/order_history/data/repositories/fake_order_history_repository.dart';
import '../../features/order_history/presentation/cubit/order_history_cubit.dart';
import '../../features/order_history/presentation/cubit/order_success_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<FlutterSecureStorage>(secureStorage);

  // Core
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));

  // --- Onboarding Feature ---

  // Datasources
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt()),
  );

  // Cubits
  getIt.registerFactory(() => OnboardingCubit(getIt()));

  // --- Auth Feature ---

  // Datasources
  getIt.registerLazySingleton(() => AuthApiService(getIt()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => FakeAuthRepository(getIt()),
    // () => RemoteAuthRepository(getIt(), getIt()),
  );

  // Cubits
  getIt.registerFactory(() => AuthCubit(getIt()));

  // --- Home Feature ---

  // Datasources
  getIt.registerLazySingleton(() => HomeApiService(getIt()));

  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => FakeHomeRepository(),
    // () => RemoteHomeRepository(getIt()),
  );

  // Cubits
  getIt.registerLazySingleton(() => HomeCubit(getIt()));

  // --- Restaurant Details Feature ---

  // Repositories
  getIt.registerLazySingleton<RestaurantRepository>(
    () => FakeRestaurantRepository(),
    // () => RemoteRestaurantRepository(getIt()),
  );

  // Cubits
  getIt.registerFactory(() => RestaurantDetailsCubit(getIt()));

  // --- Search Feature ---
  getIt.registerLazySingleton<SearchRepository>(
    () => FakeSearchRepository(getIt()),
  );
  getIt.registerFactory(() => SearchCubit(getIt()));

  // --- Profile Feature ---
  getIt.registerLazySingleton<ProfileRepository>(
    () => FakeProfileRepository(),
  );
  getIt.registerFactory(() => ProfileCubit(getIt()));

  // --- Food Details Feature ---
  getIt.registerLazySingleton<FoodDetailsRepository>(
    () => FakeFoodDetailsRepository(),
  );
  getIt.registerFactory(() => FoodDetailsCubit(getIt(), getIt()));

  // --- Settings Feature ---
  getIt.registerLazySingleton<SettingsRepository>(
    () => FakeSettingsRepository(),
  );
  getIt.registerFactory(() => SettingsCubit(getIt()));

  // --- Cart Feature ---
  getIt.registerLazySingleton<CartRepository>(
    () => FakeCartRepository(),
    // () => RemoteCartRepository(getIt()),
  );
  getIt.registerFactory(() => CartCubit(getIt()));

  // --- Favorites Feature ---
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FakeFavoritesRepository(getIt()),
    // () => RemoteFavoritesRepository(getIt()),
  );
  getIt.registerFactory(() => FavoritesCubit(getIt()));

  // --- Order Tracking Feature ---
  getIt.registerLazySingleton<OrderTrackingRepository>(
    () => FakeOrderTrackingRepository(),
    // () => RemoteOrderTrackingRepository(getIt()),
  );
  getIt.registerFactory(() => OrderTrackingCubit(getIt()));

  // --- Order History Feature ---
  getIt.registerLazySingleton<OrderHistoryRepository>(
    () => FakeOrderHistoryRepository(),
    // () => RemoteOrderHistoryRepository(getIt()),
  );
  getIt.registerFactory(() => OrderHistoryCubit(getIt()));
  getIt.registerFactory(() => OrderSuccessCubit());
}

