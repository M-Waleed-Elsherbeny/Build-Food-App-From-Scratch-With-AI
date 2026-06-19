import 'package:equatable/equatable.dart';
import '../../data/models/address_model.dart';
import '../../data/models/settings_model.dart';
import '../../data/models/user_profile_model.dart';

enum ProfileStatus { initial, loading, loaded, updated, logoutSuccess, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final UserProfileModel? user;
  final List<AddressModel> addresses;
  final SettingsModel? settings;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.addresses = const [],
    this.settings,
    this.error,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfileModel? user,
    List<AddressModel>? addresses,
    SettingsModel? settings,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      addresses: addresses ?? this.addresses,
      settings: settings ?? this.settings,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, addresses, settings, error];
}
