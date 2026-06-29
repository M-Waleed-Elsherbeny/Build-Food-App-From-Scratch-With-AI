import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized application constants.
abstract class AppConstants {
  static String get appName => dotenv.get('APP_NAME', fallback: 'FoodieGo');
  static String get supabaseUrl => dotenv.get('SUPABASE_URL', fallback: '');
  static String get supabaseKey => dotenv.get('SUPABASE_KEY', fallback: '');

  // Storage Keys
  static const String tokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String onboardingSeenKey = 'onboarding_seen';
  static const String userSessionKey = 'user_session';
}
