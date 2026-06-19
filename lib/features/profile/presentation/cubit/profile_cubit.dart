import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/settings_model.dart';
import '../../data/models/user_profile_model.dart';
import '../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState()) {
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final userResult = await _repository.getUserProfile();
    final addressResult = await _repository.getAddresses();
    final settingsResult = await _repository.getSettings();

    userResult.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, error: failure.message)),
      (user) {
        addressResult.fold(
          (failure) => emit(state.copyWith(status: ProfileStatus.error, error: failure.message)),
          (addresses) {
            settingsResult.fold(
              (failure) => emit(state.copyWith(status: ProfileStatus.error, error: failure.message)),
              (settings) {
                emit(state.copyWith(
                  status: ProfileStatus.loaded,
                  user: user,
                  addresses: addresses,
                  settings: settings,
                ));
              },
            );
          },
        );
      },
    );
  }

  Future<void> updateProfile(UserProfileModel updatedUser) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _repository.updateProfile(updatedUser);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, error: failure.message)),
      (user) => emit(state.copyWith(status: ProfileStatus.updated, user: user)),
    );
  }

  Future<void> updateSettings(SettingsModel newSettings) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _repository.updateSettings(newSettings);
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, error: failure.message)),
      (_) => emit(state.copyWith(status: ProfileStatus.updated, settings: newSettings)),
    );
  }

  Future<void> logout() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _repository.logout();
    result.fold(
      (failure) => emit(state.copyWith(status: ProfileStatus.error, error: failure.message)),
      (_) => emit(const ProfileState(status: ProfileStatus.logoutSuccess)),
    );
  }
}
