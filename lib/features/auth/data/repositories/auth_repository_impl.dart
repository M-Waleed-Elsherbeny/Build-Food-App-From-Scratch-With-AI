import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/core/constants/app_constants.dart';
import 'package:food_app/core/errors/failures.dart';
import 'package:food_app/core/models/user_model.dart';
import 'package:food_app/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth_repository.dart';

/// Implementation of [AuthRepository] using Supabase authentication.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDatasource _datasource;
  // final SessionManager _sessionManager;
  final FlutterSecureStorage _storage;


  AuthRepositoryImpl(
    this._datasource,
    //this._sessionManager,
    this._storage
  );

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final userModel = await _datasource.login(email, password);
      final user = await _storage.read(key: AppConstants.userSessionKey);
      if (user == null){
        return const Left(ServerFailure('Login failed. Please Create Account First.'));
      }
      return Right(userModel);
    } on AuthException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(ServerFailure('Login failed. Please try again later.'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _datasource.register(
        name: name,
        email: email,
        password: password,
      );
      await _storage.write(key: AppConstants.userSessionKey, value: json.encode(userModel.toJson()));
      return Right(userModel);
    } on AuthException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(
          ServerFailure('Registration failed. Please try again later.'));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String email, String otp) async {
    try {
      await _datasource.verifyOtp(email, otp);
      return const Right(null);
    } on AuthException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(ServerFailure('OTP verification failed.'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await _datasource.forgotPassword(email);
      return const Right(null);
    } on AuthException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to send reset email.'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      String email, String newPassword) async {
    try {
      await _datasource.resetPassword(newPassword);
      return const Right(null);
    } on AuthException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(ServerFailure('Failed to reset password.'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _datasource.signOut();
      return const Right(null);
    } on AuthException catch (error) {
      return Left(ServerFailure(error.message));
    } catch (_) {
      return const Left(CacheFailure('Failed to logout.'));
    }
  }

  // @override
  // Future<bool> isAuthenticated() async {
  //   return _sessionManager.isAuthenticatedAsync();
  // }
}
