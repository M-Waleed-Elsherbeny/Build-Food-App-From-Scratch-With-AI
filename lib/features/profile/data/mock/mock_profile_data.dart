import '../models/address_model.dart';
import '../models/settings_model.dart';
import '../models/user_profile_model.dart';

class MockProfileData {
  static const UserProfileModel userProfile = UserProfileModel(
    id: 'u_12345',
    name: 'Ahmed Mohamed',
    email: 'ahmed.mohamed@example.com',
    phone: '+20 100 123 4567',
    avatarUrl: 'https://i.pravatar.cc/300',
  );

  static const List<AddressModel> addresses = [
    AddressModel(
      id: 'a_1',
      title: 'Home',
      fullAddress: '123 Maadi St, Cairo, Egypt',
      isDefault: true,
    ),
    AddressModel(
      id: 'a_2',
      title: 'Work',
      fullAddress: '45 Smart Village, Giza, Egypt',
      isDefault: false,
    ),
  ];

  static const SettingsModel settings = SettingsModel(
    pushNotifications: true,
    emailPromos: false,
    darkMode: false,
  );
}
