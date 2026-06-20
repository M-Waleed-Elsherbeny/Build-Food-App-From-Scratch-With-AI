import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/profile_model.dart';
import '../models/address_model.dart';
import 'profile_repository.dart';

/// Fake implementation of [ProfileRepository] for local demo/testing.
class FakeProfileRepository implements ProfileRepository {
  ProfileModel _profile = ProfileModel.mock();

  Future<void> _delay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      await _delay();
      return Right(_profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? avatar,
  }) async {
    try {
      await _delay();
      _profile = _profile.copyWith(
        name: name,
        email: email,
        phone: phone,
        avatar: avatar ?? _profile.avatar,
      );
      return Right(_profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> addAddress(AddressModel address) async {
    try {
      await _delay();
      List<AddressModel> updatedAddresses = List.from(_profile.addresses);
      
      // If the new address is marked default, unset other defaults
      if (address.isDefault) {
        updatedAddresses = updatedAddresses.map((e) => e.copyWith(isDefault: false)).toList();
      }
      
      updatedAddresses.add(address);
      _profile = _profile.copyWith(addresses: updatedAddresses);
      return Right(_profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateAddress(AddressModel address) async {
    try {
      await _delay();
      List<AddressModel> updatedAddresses = _profile.addresses.map((e) {
        if (e.id == address.id) {
          return address;
        }
        if (address.isDefault && e.isDefault) {
          // If we updated an address to be default, unset default on other addresses
          return e.copyWith(isDefault: false);
        }
        return e;
      }).toList();

      _profile = _profile.copyWith(addresses: updatedAddresses);
      return Right(_profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> deleteAddress(String addressId) async {
    try {
      await _delay();
      List<AddressModel> updatedAddresses = _profile.addresses.where((e) => e.id != addressId).toList();
      
      // If the deleted address was default, make the first remaining address default (if any)
      final deletedWasDefault = _profile.addresses.firstWhere((e) => e.id == addressId, orElse: () => const AddressModel(id: '', title: '', addressLine: '')).isDefault;
      if (deletedWasDefault && updatedAddresses.isNotEmpty) {
        updatedAddresses[0] = updatedAddresses[0].copyWith(isDefault: true);
      }

      _profile = _profile.copyWith(addresses: updatedAddresses);
      return Right(_profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> setAsDefaultAddress(String addressId) async {
    try {
      await _delay();
      List<AddressModel> updatedAddresses = _profile.addresses.map((e) {
        return e.copyWith(isDefault: e.id == addressId);
      }).toList();

      _profile = _profile.copyWith(addresses: updatedAddresses);
      return Right(_profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
