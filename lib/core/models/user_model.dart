class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? avatar;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? json['user_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['full_name'] as String? ?? json['name'] as String?,
      avatar: json['avatar_url'] as String? ?? json['avatar'] as String?,
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
}

