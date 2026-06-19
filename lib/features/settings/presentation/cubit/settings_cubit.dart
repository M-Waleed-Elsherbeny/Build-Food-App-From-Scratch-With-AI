import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _repository;

  SettingsCubit(this._repository) : super(const SettingsState()) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    final result = await _repository.getSettings();
    result.fold(
      (failure) => emit(state.copyWith(status: SettingsStatus.error, error: failure.message)),
      (settings) => emit(state.copyWith(status: SettingsStatus.loaded, settings: settings)),
    );
  }

  Future<void> updateTheme(bool isDarkMode) async {
    if (state.settings == null) return;
    
    // Optimistic update
    final newSettings = state.settings!.copyWith(isDarkMode: isDarkMode);
    emit(state.copyWith(status: SettingsStatus.loading));

    final result = await _repository.updateTheme(isDarkMode);
    result.fold(
      (failure) {
        emit(state.copyWith(status: SettingsStatus.error, error: failure.message));
        loadSettings(); // Reload to revert optimistic update
      },
      (_) => emit(state.copyWith(status: SettingsStatus.updated, settings: newSettings)),
    );
  }

  Future<void> updateLanguage(String language) async {
    if (state.settings == null) return;
    
    final newSettings = state.settings!.copyWith(language: language);
    emit(state.copyWith(status: SettingsStatus.loading));

    final result = await _repository.updateLanguage(language);
    result.fold(
      (failure) {
        emit(state.copyWith(status: SettingsStatus.error, error: failure.message));
        loadSettings();
      },
      (_) => emit(state.copyWith(status: SettingsStatus.updated, settings: newSettings)),
    );
  }

  Future<void> updateNotifications(bool push, bool promo) async {
    if (state.settings == null) return;
    
    final newSettings = state.settings!.copyWith(pushNotifications: push, promoEmails: promo);
    emit(state.copyWith(status: SettingsStatus.loading));

    final result = await _repository.updateNotifications(push, promo);
    result.fold(
      (failure) {
        emit(state.copyWith(status: SettingsStatus.error, error: failure.message));
        loadSettings();
      },
      (_) => emit(state.copyWith(status: SettingsStatus.updated, settings: newSettings)),
    );
  }
}
