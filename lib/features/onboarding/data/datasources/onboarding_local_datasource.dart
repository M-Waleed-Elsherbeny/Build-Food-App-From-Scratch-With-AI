import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveOnboardingCompletion();
  Future<bool> isOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences sharedPreferences;

  OnboardingLocalDataSourceImpl(this.sharedPreferences);

  static const String _kOnboardingCompletedKey = 'hasCompletedOnboarding';

  @override
  Future<void> saveOnboardingCompletion() async {
    await sharedPreferences.setBool(_kOnboardingCompletedKey, true);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return sharedPreferences.getBool(_kOnboardingCompletedKey) ?? false;
  }
}

