import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handleError(DioException error) {
    String errorMessage = "An unknown error occurred.";

    if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage =
          'Connection timeout. Please check your internet connection.';
    } else if (error.type == DioExceptionType.sendTimeout) {
      errorMessage = 'Request timeout. The server took too long to respond.';
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Response timeout. The server took too long to respond.';
    } else if (error.type == DioExceptionType.badResponse) {
      errorMessage =
          "Error ${error.response?.statusCode}: ${error.response?.statusMessage ?? 'Unknown error'}";
    } else if (error.type == DioExceptionType.cancel) {
      errorMessage = 'Request was cancelled. Please try again.';
    } else {
      errorMessage = 'Unexpected error: ${error.message}';
    }

    return errorMessage;
  }
}
