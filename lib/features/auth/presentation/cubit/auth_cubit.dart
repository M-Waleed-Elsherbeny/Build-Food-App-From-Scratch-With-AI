import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_state.dart';

/// Cubit responsible for managing authentication state and actions.
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState());

  /// Authenticates a user with email and password.
  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.login(email, password);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.failure, error: failure.message)),
      (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
    );
  }

  /// Registers a new user with the provided details.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.register(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.failure, error: failure.message)),
      (user) => emit(state.copyWith(status: AuthStatus.success, user: user)),
    );
  }

  /// Initiates the forgot password process.
  Future<void> forgotPassword(String email) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.forgotPassword(email);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.failure, error: failure.message)),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  /// Verifies the OTP code sent to the user's email.
  Future<void> verifyOtp(String email, String otp) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.verifyOtp(email, otp);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.failure, error: failure.message)),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  /// Resets the user's password using the provided details.
  Future<void> resetPassword(String email, String newPassword) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.resetPassword(email, newPassword);
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.failure, error: failure.message)),
      (_) => emit(state.copyWith(status: AuthStatus.success)),
    );
  }

  /// Logs out the current user.
  Future<void> logout() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _authRepository.logout();
    result.fold(
      (failure) => emit(state.copyWith(status: AuthStatus.failure, error: failure.message)),
      (_) => emit(const AuthState()),
    );
  }

  /// Resets the cubit status to initial.
  void resetStatus() {
    emit(state.copyWith(status: AuthStatus.initial, error: null));
  }
}

