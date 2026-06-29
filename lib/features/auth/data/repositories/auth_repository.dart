import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';

/// Repository interface for authentication operations.
abstract class AuthRepository {
  /// Authenticates a user with email and password.
  Future<Either<Failure, UserModel>> login(String email, String password);
  
  /// Registers a new user with the provided details.
  Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
  });
  
  /// Verifies the OTP code sent to the user's email.
  Future<Either<Failure, void>> verifyOtp(String email, String otp);
  
  /// Initiates the forgot password process.
  Future<Either<Failure, void>> forgotPassword(String email);
  
  /// Resets the user's password using the provided details.
  Future<Either<Failure, void>> resetPassword(String email, String newPassword);
  
  /// Logs out the current user.
  Future<Either<Failure, void>> logout();

  // /// Checks if the user is currently authenticated.
  // Future<bool> isAuthenticated();
}

