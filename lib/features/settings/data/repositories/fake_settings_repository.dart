import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_settings_data.dart';
import '../models/settings_model.dart';
import 'settings_repository.dart';

class FakeSettingsRepository implements SettingsRepository {
  SettingsModel _settings = MockSettingsData.defaultSettings;

  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      await _delay();
      return Right(_settings);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(SettingsModel settings) async {
    try {
      await _delay();
      _settings = settings;
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTheme(bool isDarkMode) async {
    try {
      await _delay();
      _settings = _settings.copyWith(isDarkMode: isDarkMode);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateLanguage(String language) async {
    try {
      await _delay();
      _settings = _settings.copyWith(language: language);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNotifications(bool push, bool promo) async {
    try {
      await _delay();
      _settings = _settings.copyWith(pushNotifications: push, promoEmails: promo);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
