import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../../core/errors/auth_exception.dart';
import '../models/auth_user_model.dart';

/// Datasource implementation that uses Supabase Auth for authentication.
class SupabaseAuthDatasource {
  final supabase.SupabaseClient _supabaseClient;

  SupabaseAuthDatasource(this._supabaseClient);

  Future<AuthUserModel> login(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user ?? _supabaseClient.auth.currentUser;
      if (user == null) {
        throw const AuthException('Login failed. User data is missing.');
      }

      return AuthUserModel.fromUser(user);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  Future<AuthUserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      final user = response.user ?? _supabaseClient.auth.currentUser;
      if (user == null) {
        throw const AuthException('Registration failed. User data is missing.');
      }

      // Optionally update metadata later if needed.
      return AuthUserModel.fromUser(user);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    // Supabase password reset flow uses email links instead of OTP codes.
    // Keep this as a no-op to preserve existing UI flows.
    return;
  }

  Future<void> forgotPassword(String email) async {
    try {
      // Try the most common SDK entry points for password reset. We call
      // them in sequence and ignore NoSuchMethodErrors so this datasource
      // stays compatible across SDK versions.
      try {
        await _supabaseClient.auth.resetPasswordForEmail(email);
        return;
      } catch (e) {
        throw AuthException('Password reset failed: ${e.toString()}');
      }
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  Future<void> resetPassword(String newPassword) async {
    // Resetting password typically happens via the magic/email link flow.
    // If a session exists and updateUser API is available it can be used.
    final session = _supabaseClient.auth.currentSession;
    if (session == null) {
      throw const AuthException(
        'Password reset session is not available. Please complete the reset flow from the email link.',
      );
    }

    try {
      // Try to call updateUser dynamically; if it doesn't exist this will
      // throw and be handled below.
      final dynamic auth = _supabaseClient.auth;
      await auth.updateUser({'password': newPassword});
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}
