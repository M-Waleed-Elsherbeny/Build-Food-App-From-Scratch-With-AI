// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../../constants/app_constants.dart';

// /// Interceptor that adds authentication token to every request.
// class AuthInterceptor extends Interceptor {
//   final FlutterSecureStorage _storage;

//   AuthInterceptor(this._storage);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     final token = await _storage.read(key: AppConstants.tokenKey);
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     super.onRequest(options, handler);
//   }
// }

