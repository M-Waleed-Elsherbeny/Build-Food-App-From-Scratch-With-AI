import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/address_model.dart';
import '../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

/// Cubit responsible for managing the user profile lifecycle and state transitions.
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileState());

  /// Loads the user's profile details.
  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.getProfile();
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }

  /// Updates the user's profile details.
  Future<void> editProfile({
    required String name,
    required String email,
    required String phone,
    String? avatar,
  }) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.updateProfile(
      name: name,
      email: email,
      phone: phone,
      avatar: avatar,
    );
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }

  /// Adds a new address to the profile.
  Future<void> addAddress(AddressModel address) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.addAddress(address);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }

  /// Updates an existing address.
  Future<void> updateAddress(AddressModel address) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.updateAddress(address);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }

  /// Deletes an address.
  Future<void> deleteAddress(String addressId) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.deleteAddress(addressId);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }

  /// Sets an address as the default address.
  Future<void> setAsDefaultAddress(String addressId) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _profileRepository.setAsDefaultAddress(addressId);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.failure, error: failure.message)),
      (profile) => emit(state.copyWith(status: ProfileStatus.success, profile: profile)),
    );
  }
}
