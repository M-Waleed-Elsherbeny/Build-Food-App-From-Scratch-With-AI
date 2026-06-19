import 'package:equatable/equatable.dart';

class SettingsModel extends Equatable {
  final bool isDarkMode;
  final String language; // 'en', 'ar', etc.
  final bool pushNotifications;
  final bool promoEmails;

  const SettingsModel({
    this.isDarkMode = false,
    this.language = 'en',
    this.pushNotifications = true,
    this.promoEmails = false,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      isDarkMode: json['isDarkMode'] ?? false,
      language: json['language'] ?? 'en',
      pushNotifications: json['pushNotifications'] ?? true,
      promoEmails: json['promoEmails'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isDarkMode': isDarkMode,
      'language': language,
      'pushNotifications': pushNotifications,
      'promoEmails': promoEmails,
    };
  }

  SettingsModel copyWith({
    bool? isDarkMode,
    String? language,
    bool? pushNotifications,
    bool? promoEmails,
  }) {
    return SettingsModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      promoEmails: promoEmails ?? this.promoEmails,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, language, pushNotifications, promoEmails];
}
