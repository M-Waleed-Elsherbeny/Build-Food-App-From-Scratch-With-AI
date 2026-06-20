import 'package:equatable/equatable.dart';
import '../../data/models/profile_model.dart';

enum ProfileStatus { initial, loading, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileModel? profile;
  final String? error;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.error,
  });

  /// Returns a copy of this state with the given fields replaced.
  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profile,
    String? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, profile, error];
}
