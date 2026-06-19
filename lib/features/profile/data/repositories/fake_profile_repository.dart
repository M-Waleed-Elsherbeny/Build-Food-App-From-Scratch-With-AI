import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../mock/mock_profile_data.dart';
import '../models/address_model.dart';
import '../models/settings_model.dart';
import '../models/user_profile_model.dart';
import 'profile_repository.dart';

class FakeProfileRepository implements ProfileRepository {
  UserProfileModel _currentUser = MockProfileData.userProfile;
  List<AddressModel> _addresses = List.from(MockProfileData.addresses);
  SettingsModel _settings = MockProfileData.settings;

  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile() async {
    try {
      await _delay();
      return Right(_currentUser);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> updateProfile(UserProfileModel profile) async {
    try {
      await _delay();
      _currentUser = profile;
      return Right(_currentUser);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    try {
      await _delay();
      return Right(_addresses);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveAddress(AddressModel address) async {
    try {
      await _delay();
      final index = _addresses.indexWhere((a) => a.id == address.id);
      if (index >= 0) {
        _addresses[index] = address;
      } else {
        _addresses.add(address);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String id) async {
    try {
      await _delay();
      _addresses.removeWhere((a) => a.id == id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      await _delay();
      return Right(_settings);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSettings(SettingsModel settings) async {
    try {
      await _delay();
      _settings = settings;
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _delay();
      // Reset local fake data if needed
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
