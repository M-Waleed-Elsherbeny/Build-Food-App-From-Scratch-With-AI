import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/session_manager.dart';
import '../datasources/supabase_auth_datasource.dart';
import '../mappers/auth_mapper.dart';
import '../../../../core/models/user_model.dart';
import 'auth_repository.dart';

/// Implementation of [AuthRepository] using Supabase authentication.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthDatasource _datasource;
  final SessionManager _sessionManager;

  AuthRepositoryImpl(
    this._datasource,
    this._sessionManager,
  );

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final authUser = await _datasource.login(email, password);
      return Right(authUser.toDomain());
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
      final authUser = await _datasource.register(
        name: name,
        email: email,
        password: password,
      );
      return Right(authUser.toDomain());
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

  @override
  Future<bool> isAuthenticated() async {
    return _sessionManager.isAuthenticatedAsync();
  }
}
