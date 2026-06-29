// import 'package:supabase_flutter/supabase_flutter.dart';

// /// Internal model used to map Supabase user data to the app domain.
// class AuthUserModel {
//   final String id;
//   final String email;
//   final String? name;
//   final String? avatar;
//   final Map<String, dynamic>? metadata;

//   const AuthUserModel({
//     required this.id,
//     required this.email,
//     this.name,
//     this.avatar,
//     this.metadata,
//   });

//   factory AuthUserModel.fromUser(User user) {
//     final rawMetadata = user.userMetadata;
//     final metadata = rawMetadata is Map<String, dynamic> ? rawMetadata : null;

//     return AuthUserModel(
//       id: user.id,
//       email: user.email ?? '',
//       name: metadata?['full_name'] as String? ?? metadata?['name'] as String?,
//       avatar: metadata?['avatar_url'] as String? ?? metadata?['avatar'] as String?,
//       metadata: metadata,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'name': name,
//       'avatar': avatar,
//       'metadata': metadata,
//     };
//   }

//   AuthUserModel copyWith({
//     String? id,
//     String? email,
//     String? name,
//     String? avatar,
//     Map<String, dynamic>? metadata,
//   }) {
//     return AuthUserModel(
//       id: id ?? this.id,
//       email: email ?? this.email,
//       name: name ?? this.name,
//       avatar: avatar ?? this.avatar,
//       metadata: metadata ?? this.metadata,
//     );
//   }
// }
