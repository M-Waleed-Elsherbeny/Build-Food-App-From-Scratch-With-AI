import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';
import '../datasources/auth_api_service.dart';
import 'auth_repository.dart';

/// Remote implementation of [AuthRepository] using live API.
/// This is prepared for future use but disabled by default.
class RemoteAuthRepository implements AuthRepository {
  final AuthApiService _apiService;
  final FlutterSecureStorage _secureStorage;

  RemoteAuthRepository(
    this._apiService,
    this._secureStorage,
  );

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async {
    try {
      final data = await _apiService.login(email, password);
      final user = UserModel.fromJson(data['user']);
      final token = data['token'];

      if (token != null) {
        await _secureStorage.write(key: AppConstants.tokenKey, value: token);
      }

      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Login failed'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final data = await _apiService.register(
        name: name,
        email: email,
        password: password,
      );
      final user = UserModel.fromJson(data['user']);
      final token = data['token'];

      if (token != null) {
        await _secureStorage.write(key: AppConstants.tokenKey, value: token);
      }

      return Right(user);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Registration failed'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String email, String otp) async {
    try {
      await _apiService.verifyOtp(email, otp);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'OTP verification failed'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _apiService.forgotPassword(email);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Failed to send reset email'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email, String newPassword) async {
    try {
      await _apiService.resetPassword(email, newPassword);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Failed to reset password'));
    } catch (e) {
      return const Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _secureStorage.delete(key: AppConstants.tokenKey);
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to logout'));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: AppConstants.tokenKey);
    return token != null;
  }
}
