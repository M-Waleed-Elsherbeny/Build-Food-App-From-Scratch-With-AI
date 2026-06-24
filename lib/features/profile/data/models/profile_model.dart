import '../../../../core/models/user_model.dart';
import 'address_model.dart';
import 'package:equatable/equatable.dart';

class ProfileModel extends UserModel with EquatableMixin {
  final String phone;
  final List<AddressModel> addresses;

  const ProfileModel({
    required super.id,
    required super.email,
    super.name,
    super.avatar,
    required this.phone,
    required this.addresses,
  });

  /// Factory constructor to parse a [ProfileModel] from JSON.
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    var addressesList = json['addresses'] as List? ?? [];
    List<AddressModel> addresses = addressesList
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ProfileModel(
      id: json['id'] as String? ?? json['user_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['full_name'] as String? ?? json['name'] as String?,
      avatar: json['avatar_url'] as String? ?? json['avatar'] as String?,
      phone: json['phone_number'] as String? ?? json['phone'] as String? ?? '',
      addresses: addresses,
    );
  }

  /// Converts this [ProfileModel] to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': name,
      'avatar_url': avatar,
      'phone_number': phone,
      'addresses': addresses.map((e) => e.toJson()).toList(),
    };
  }

  /// Creates a copy of this [ProfileModel] with the given fields replaced.
  @override
  ProfileModel copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    String? phone,
    List<AddressModel>? addresses,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      addresses: addresses ?? this.addresses,
    );
  }
  
  /// Helper to generate default mock profile.
  factory ProfileModel.mock() {
    return const ProfileModel(
      id: '1',
      name: 'Waleed Ahmed',
      email: 'waleed.ahmed@foodiego.com',
      phone: '+1 (555) 012-3456',
      avatar: 'http://localhost:3845/assets/974fe84cc68cbc4839607d5f67a91ae17be70761.png',
      addresses: [
        AddressModel(
          id: '1',
          title: 'Home',
          addressLine: '123 Orange Street, Heliopolis, Cairo',
          isDefault: true,
        ),
        AddressModel(
          id: '2',
          title: 'Work',
          addressLine: 'Smart Village, Building B-12, Giza',
          isDefault: false,
        ),
      ],
    );
  }

  @override
  List<Object?> get props => [id, email, name, avatar, phone, addresses];
}
