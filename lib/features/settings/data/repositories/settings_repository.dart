import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/settings_model.dart';

abstract class SettingsRepository {
  Future<Either<Failure, SettingsModel>> getSettings();
  Future<Either<Failure, void>> saveSettings(SettingsModel settings);
  
  // Specific toggles
  Future<Either<Failure, void>> updateTheme(bool isDarkMode);
  Future<Either<Failure, void>> updateLanguage(String language);
  Future<Either<Failure, void>> updateNotifications(bool push, bool promo);
}
