import 'package:food_app/core/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../../../../core/errors/auth_exception.dart';

/// Datasource implementation that uses Supabase Auth for authentication.
class SupabaseAuthDatasource {
  final supabase.SupabaseClient _supabaseClient;

  SupabaseAuthDatasource(this._supabaseClient);

  Future<UserModel> login(String email, String password) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user ?? _supabaseClient.auth.currentUser;
    if (user == null) {
      throw const AuthException('Login failed. User data is missing.');
    }
    return UserModel.fromUser(user: user);
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
    );

    // Fetch profile details
    await _supabaseClient.from("profiles").insert({
      "id": response.user!.id,
      "email": email,
      "full_name": name,
      "avatar_url": "https://cdn-icons-png.flaticon.com/512/149/149071.png",
    });
    // final user = response.user ?? _supabaseClient.auth.currentUser;
    // if (user == null) {
    //   throw const AuthException('Registration failed. User data is missing.');
    // }

    // Optionally update metadata later if needed.
    return UserModel.fromUser(
      user: response.user!,
      name: name,
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    // Supabase password reset flow uses email links instead of OTP codes.
    // Keep this as a no-op to preserve existing UI flows.
    return;
  }

  Future<void> forgotPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
    return;
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
    // Try to call updateUser dynamically; if it doesn't exist this will
    // throw and be handled below.
    final dynamic auth = _supabaseClient.auth;
    await auth.updateUser({'password': newPassword});
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
