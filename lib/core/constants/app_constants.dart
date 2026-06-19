import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized application constants.
abstract class AppConstants {
  static String get appName => dotenv.get('APP_NAME', fallback: 'FoodieGo');
  static String get baseUrl => dotenv.get('BASE_URL', fallback: 'https://api.foodiego.com/v1');
  
  // Storage Keys
  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String onboardingSeenKey = 'onboarding_seen';
}

/// API endpoints for the application.
abstract class AppEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  
  // Home
  static const String categories = '/home/categories';
  static const String restaurants = '/home/restaurants';
  static const String offers = '/home/offers';
  static const String meals = '/home/meals';
}

