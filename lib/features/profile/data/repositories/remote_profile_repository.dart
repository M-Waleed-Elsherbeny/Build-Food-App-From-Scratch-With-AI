import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../models/address_model.dart';
import '../models/settings_model.dart';
import '../models/user_profile_model.dart';
import 'profile_repository.dart';

class RemoteProfileRepository implements ProfileRepository {
  final Dio _dio;

  RemoteProfileRepository(this._dio);

  @override
  Future<Either<Failure, UserProfileModel>> getUserProfile() async {
    try {
      // final response = await _dio.get('/api/v1/profile');
      // return Right(UserProfileModel.fromJson(response.data['data']));
      throw UnimplementedError();
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfileModel>> updateProfile(UserProfileModel profile) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AddressModel>>> getAddresses() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveAddress(AddressModel address) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteAddress(String id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateSettings(SettingsModel settings) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      // await _dio.post('/api/v1/auth/logout');
      // return const Right(null);
      throw UnimplementedError();
    } on DioException catch (e) {
      return Left(ErrorHandler.handle(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
