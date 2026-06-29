// import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
// import 'package:food_app/features/auth/data/models/auth_user_model.dart';
// import 'package:food_app/features/auth/data/mappers/auth_mapper.dart';
// import 'package:food_app/core/models/user_model.dart';

// /// Manages Supabase authentication session state and provides helper utilities.
// class SessionManager {
//   final supabase.SupabaseClient _client;

//   SessionManager(this._client);

//   bool get isAuthenticated => _client.auth.currentSession != null;

//   Future<bool> isAuthenticatedAsync() async {
//     return _client.auth.currentSession != null;
//   }

//   UserModel? get currentUser {
//     final user = _client.auth.currentUser;
//     if (user == null) return null;
//     return AuthUserModel.fromUser(user).toDomain();
//   }

//   Stream<supabase.AuthState> get authStateChanges {
//     return _client.auth.onAuthStateChange;
//   }
// }
