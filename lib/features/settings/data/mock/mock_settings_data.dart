import '../models/settings_model.dart';

class MockSettingsData {
  static const SettingsModel defaultSettings = SettingsModel(
    isDarkMode: false,
    language: 'en',
    pushNotifications: true,
    promoEmails: false,
  );
}
