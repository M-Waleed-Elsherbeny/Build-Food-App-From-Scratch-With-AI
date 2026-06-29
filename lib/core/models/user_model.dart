import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String avatar;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['full_name'] ?? "",
      avatar: json['avatar_url'] ?? "",
    );
  }

  factory UserModel.fromUser({required User user, String? name}) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: name ?? "Unknown Name",
      avatar: user.userMetadata?['avatar_url'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': name,
      'avatar_url': avatar,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  List<Object?> get props => [id, email, name, avatar];
}
