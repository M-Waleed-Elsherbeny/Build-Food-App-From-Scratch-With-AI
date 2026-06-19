import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';
import 'auth_repository.dart';

/// Fake implementation of [AuthRepository] for demo and local testing.
class FakeAuthRepository implements AuthRepository {
  final FlutterSecureStorage _secureStorage;

  FakeAuthRepository(this._secureStorage);

  @override
  Future<Either<Failure, UserModel>> login(String email, String password) async {
    // Simulated network delay
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Demo credentials
    if (email == 'test@foodiego.com' && password == '12345678') {
      final user = UserModel(
        id: '1',
        name: 'John Doe',
        email: email,
      );
      await _secureStorage.write(key: AppConstants.tokenKey, value: 'fake_token_123');
      return Right(user);
    } else {
      return const Left(ServerFailure('Invalid email or password. Use test@foodiego.com / 12345678'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final user = UserModel(
      id: '2',
      name: name,
      email: email,
    );
    await _secureStorage.write(key: AppConstants.tokenKey, value: 'fake_token_456');
    return Right(user);
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String email, String otp) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Simulate error for invalid OTP
    if (otp == '1234') {
      return const Right(null);
    } else {
      return const Left(ValidationFailure('Invalid OTP. Please use 1234'));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email, String newPassword) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await _secureStorage.delete(key: AppConstants.tokenKey);
    return const Right(null);
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: AppConstants.tokenKey);
    return token != null;
  }
}
