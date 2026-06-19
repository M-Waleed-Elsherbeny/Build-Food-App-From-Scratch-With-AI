import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/address_model.dart';
import '../models/settings_model.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfileModel>> getUserProfile();
  Future<Either<Failure, UserProfileModel>> updateProfile(UserProfileModel profile);
  
  Future<Either<Failure, List<AddressModel>>> getAddresses();
  Future<Either<Failure, void>> saveAddress(AddressModel address);
  Future<Either<Failure, void>> deleteAddress(String id);
  
  Future<Either<Failure, SettingsModel>> getSettings();
  Future<Either<Failure, void>> updateSettings(SettingsModel settings);
  
  Future<Either<Failure, void>> logout();
}
