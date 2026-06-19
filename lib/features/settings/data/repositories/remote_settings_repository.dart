import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../models/settings_model.dart';
import 'settings_repository.dart';

class RemoteSettingsRepository implements SettingsRepository {
  final Dio _dio;

  RemoteSettingsRepository(this._dio);

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      throw UnimplementedError();
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(SettingsModel settings) async {
    try {
      throw UnimplementedError();
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTheme(bool isDarkMode) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateLanguage(String language) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateNotifications(bool push, bool promo) async {
    throw UnimplementedError();
  }
}
