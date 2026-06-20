import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/network/api_client.dart';
import '../models/profile_model.dart';
import '../models/address_model.dart';
import 'profile_repository.dart';

/// Remote implementation of [ProfileRepository] using [ApiClient] for network requests.
class RemoteProfileRepository implements ProfileRepository {
  final ApiClient _apiClient;

  RemoteProfileRepository(this._apiClient);

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await _apiClient.get('/profile');
      final profile = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
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
      final response = await _apiClient.post(
        '/profile/update',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          if (avatar != null) 'avatar': avatar,
        },
      );
      final profile = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> addAddress(AddressModel address) async {
    try {
      final response = await _apiClient.post(
        '/profile/addresses',
        data: address.toJson(),
      );
      final profile = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateAddress(AddressModel address) async {
    try {
      final response = await _apiClient.post(
        '/profile/addresses/${address.id}',
        data: address.toJson(),
      );
      final profile = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> deleteAddress(String addressId) async {
    try {
      final response = await _apiClient.post('/profile/addresses/$addressId/delete');
      final profile = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> setAsDefaultAddress(String addressId) async {
    try {
      final response = await _apiClient.post('/profile/addresses/$addressId/default');
      final profile = ProfileModel.fromJson(response.data as Map<String, dynamic>);
      return Right(profile);
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
