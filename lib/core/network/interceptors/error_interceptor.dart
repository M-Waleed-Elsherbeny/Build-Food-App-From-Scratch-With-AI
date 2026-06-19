import 'package:dio/dio.dart';

/// Interceptor that handles and formats network errors.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle specific error codes or message formats here
    super.onError(err, handler);
  }
}

