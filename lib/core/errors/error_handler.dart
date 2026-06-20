import 'package:dio/dio.dart';
import 'failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return const ServerFailure('An unexpected error occurred');
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout. Please try again later.');
      case DioExceptionType.badResponse:
        if (error.response != null) {
          return _handleServerResponseError(error.response!);
        }
        return const ServerFailure('Bad response from server');
      case DioExceptionType.cancel:
        return const ServerFailure('Request was cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No Internet Connection');
      case DioExceptionType.badCertificate:
        return const ServerFailure('Bad certificate error');
      case DioExceptionType.unknown:
        return const ServerFailure('An unknown error occurred');
    }
  }

  static Failure _handleServerResponseError(Response response) {
    final statusCode = response.statusCode;
    final data = response.data;

    String message = 'Server Error occurred';

    if (data is Map<String, dynamic> && data.containsKey('message')) {
      message = data['message'];
    }

    if (statusCode == 400) {
      return ValidationFailure(message);
    } else if (statusCode == 401 || statusCode == 403) {
      return ServerFailure(message); // Could create AuthFailure for this
    } else if (statusCode == 404) {
      return const ServerFailure('Resource not found');
    } else if (statusCode != null && statusCode >= 500) {
      return const ServerFailure('Internal server error. Please try again later.');
    }

    return ServerFailure(message);
  }
}
