import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failures.dart';
import '../models/profile_model.dart';
import '../models/address_model.dart';
import 'profile_repository.dart';

/// Implementation of [ProfileRepository] using Supabase.
class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseClient _supabaseClient;

  ProfileRepositoryImpl(this._supabaseClient);

  String get _currentUserId {
    final user = _supabaseClient.auth.currentUser;
    if (user == null) {
      throw const AuthException('No authenticated user found');
    }
    return user.id;
  }

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final userId = _currentUserId;
      
      // Fetch profile details
      final profileData = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      // Fetch addresses
      final addressesData = await _supabaseClient
          .from('addresses')
          .select()
          .eq('profile_id', userId);

      final profileMap = Map<String, dynamic>.from(profileData);
      profileMap['addresses'] = addressesData;

      return Right(ProfileModel.fromJson(profileMap));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to load profile: ${e.toString()}'));
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
      final userId = _currentUserId;

      await _supabaseClient.from('profiles').update({
        'full_name': name,
        'email': email,
        'phone_number': phone,
        if (avatar != null) 'avatar_url': avatar,
      }).eq('id', userId);

      return getProfile();
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to update profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> addAddress(AddressModel address) async {
    try {
      final userId = _currentUserId;

      if (address.isDefault) {
        await _supabaseClient
            .from('addresses')
            .update({'is_default': false})
            .eq('profile_id', userId);
      }

      await _supabaseClient.from('addresses').insert({
        'profile_id': userId,
        'title': address.title,
        'address_line': address.addressLine,
        'is_default': address.isDefault,
      });

      return getProfile();
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to add address: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateAddress(AddressModel address) async {
    try {
      final userId = _currentUserId;

      if (address.isDefault) {
        await _supabaseClient
            .from('addresses')
            .update({'is_default': false})
            .eq('profile_id', userId);
      }

      await _supabaseClient.from('addresses').update({
        'title': address.title,
        'address_line': address.addressLine,
        'is_default': address.isDefault,
      }).eq('id', address.id);

      return getProfile();
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to update address: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> deleteAddress(String addressId) async {
    try {
      await _supabaseClient.from('addresses').delete().eq('id', addressId);
      return getProfile();
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to delete address: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> setAsDefaultAddress(String addressId) async {
    try {
      final userId = _currentUserId;

      await _supabaseClient
          .from('addresses')
          .update({'is_default': false})
          .eq('profile_id', userId);

      await _supabaseClient
          .from('addresses')
          .update({'is_default': true})
          .eq('id', addressId);

      return getProfile();
    } on PostgrestException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to set default address: ${e.toString()}'));
    }
  }
}
