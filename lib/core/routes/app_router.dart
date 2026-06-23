import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_cubit.dart';
import 'package:food_app/features/food_details/presentation/pages/food_details_screen.dart';
import 'package:go_router/go_router.dart';
import '../di/injection.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/auth/presentation/pages/welcome_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/search/presentation/pages/search_screen.dart';
import '../../features/search/presentation/cubit/search_cubit.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/restaurant_details/presentation/pages/restaurant_details_screen.dart';
import '../../features/restaurant_details/presentation/cubit/restaurant_details_cubit.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/cart/presentation/pages/cart_screen.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/profile/presentation/pages/manage_addresses_screen.dart';
import '../../features/order_tracking/presentation/cubit/order_tracking_cubit.dart';
import '../../features/order_tracking/presentation/screens/order_tracking_screen.dart';
import '../../features/order_tracking/data/repositories/fake_order_tracking_repository.dart';
import '../../features/order_history/presentation/screens/order_success_screen.dart';
import '../../features/order_history/presentation/cubit/order_success_cubit.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';
  static const String main = '/main';
  static const String home = '/home';
  static const String search = '/search';
  static const String restaurantDetails = '/restaurant-details';
  static const String settings = '/settings';
  static const String cart = '/cart';
  static const String foodDetails = '/food-details';
  static const String manageAddresses = '/manage-addresses';
  static const String orderTracking = '/order-tracking';
  static const String orderSuccess = '/order-success';
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OnboardingCubit>(),
          child: const OnboardingPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return OtpPage(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return ResetPasswordPage(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const MainPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<HomeCubit>(),
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => BlocProvider.value(
          value: getIt<SearchCubit>(),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.restaurantDetails,
        builder: (context, state) {
          final restaurantId = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) => getIt<RestaurantDetailsCubit>()..loadRestaurantData(restaurantId),
            child: const RestaurantDetailsScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.foodDetails,
        builder: (context, state) {
          final foodId = state.extra as String? ?? '';
          return BlocProvider(
            create: (context) => getIt<FoodDetailsCubit>()..loadFoodDetails(foodId),
            child: FoodDetailsScreen(foodId: foodId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<SettingsCubit>(),
          child: const SettingsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.cart,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<CartCubit>()..getCartItems(),
          child: const CartScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.manageAddresses,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ProfileCubit>(),
          child: const ManageAddressesScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.orderTracking,
        builder: (context, state) {
          final orderId = state.extra as String? ?? 'FG-48291';
          return BlocProvider(
            create: (context) => OrderTrackingCubit(FakeOrderTrackingRepository()),
            child: OrderTrackingScreen(orderId: orderId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orderSuccess,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<OrderSuccessCubit>(),
          child: const OrderSuccessScreen(),
        ),
      ),
    ],
  );
}
