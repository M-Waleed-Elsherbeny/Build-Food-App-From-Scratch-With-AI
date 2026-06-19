import 'package:equatable/equatable.dart';
import '../../data/models/settings_model.dart';

enum SettingsStatus { initial, loading, loaded, updated, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final SettingsModel? settings;
  final String? error;

  const SettingsState({
    this.status = SettingsStatus.initial,
    this.settings,
    this.error,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    SettingsModel? settings,
    String? error,
  }) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, settings, error];
}
