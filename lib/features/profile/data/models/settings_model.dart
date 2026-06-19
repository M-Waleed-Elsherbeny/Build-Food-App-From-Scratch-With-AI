import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final bool pushNotifications;
  final bool emailPromos;
  final bool darkMode;

  const SettingsModel({
    this.pushNotifications = true,
    this.emailPromos = false,
    this.darkMode = false,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      pushNotifications: json['pushNotifications'] ?? true,
      emailPromos: json['emailPromos'] ?? false,
      darkMode: json['darkMode'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotifications': pushNotifications,
      'emailPromos': emailPromos,
      'darkMode': darkMode,
    };
  }

  SettingsModel copyWith({
    bool? pushNotifications,
    bool? emailPromos,
    bool? darkMode,
  }) {
    return SettingsModel(
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailPromos: emailPromos ?? this.emailPromos,
      darkMode: darkMode ?? this.darkMode,
    );
  }

  @override
  List<Object?> get props => [pushNotifications, emailPromos, darkMode];
}
