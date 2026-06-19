import '../../../../core/network/api_client.dart';
import '../../../../core/constants/app_constants.dart';

class AuthApiService {
  final ApiClient _apiClient;

  AuthApiService(this._apiClient);

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await _apiClient.post(
      AppEndpoints.login,
      data: {'email': email, 'password': password},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      AppEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return response.data;
  }

  Future<void> verifyOtp(String email, String otp) async {
    await _apiClient.post(
      AppEndpoints.verifyOtp,
      data: {'email': email, 'otp': otp},
    );
  }

  Future<void> forgotPassword(String email) async {
    await _apiClient.post(
      AppEndpoints.forgotPassword,
      data: {'email': email},
    );
  }

  Future<void> resetPassword(String email, String newPassword) async {
    await _apiClient.post(
      AppEndpoints.resetPassword,
      data: {'email': email, 'new_password': newPassword},
    );
  }
}

