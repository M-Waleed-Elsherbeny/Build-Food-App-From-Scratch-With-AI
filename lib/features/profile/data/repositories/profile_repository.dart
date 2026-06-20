import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../models/profile_model.dart';
import '../models/address_model.dart';

/// Repository interface for profile operations.
abstract class ProfileRepository {
  /// Fetches the user's profile details.
  Future<Either<Failure, ProfileModel>> getProfile();

  /// Updates the user's profile information.
  Future<Either<Failure, ProfileModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? avatar,
  });

  /// Adds a new address to the user's profile.
  Future<Either<Failure, ProfileModel>> addAddress(AddressModel address);

  /// Updates an existing address in the user's profile.
  Future<Either<Failure, ProfileModel>> updateAddress(AddressModel address);

  /// Deletes an address by its ID from the user's profile.
  Future<Either<Failure, ProfileModel>> deleteAddress(String addressId);

  /// Sets the specified address as default.
  Future<Either<Failure, ProfileModel>> setAsDefaultAddress(String addressId);
}
