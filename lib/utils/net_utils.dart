import 'package:http/http.dart';
import 'package:dio/dio.dart' as Dio;

import '../models/errors/custom_exception.dart';

class NetUtils {
  static CustomException parseErrorResponse({
    required Response response,
    String? customMessage,
  }) {
    if (response.statusCode == 401) {
      return UnauthorizedException(message: response.body, errorCode: 401);
    } else if (response.statusCode == 403) {
      return ForbiddenException(message: response.body, errorCode: 403);
    } else if (response.statusCode == 404) {
      return NotFoundException(message: response.body, errorCode: 404);
    } else {
      return CustomException(message: customMessage ?? 'Unknown Error');
    }
  }

  static CustomException parseDioException(Dio.DioException e) {
    try {
      Dio.Response response = e.response!;
      String message =
          response.data['message'] ?? "Terjadi kesalahan! Silakan coba lagi.";

      if (response.statusCode == 401) {
        return UnauthorizedException(message: message);
      } else if (response.statusCode == 403) {
        return ForbiddenException(message: message);
      } else if (response.statusCode == 404) {
        return NotFoundException(message: message);
      } else {
        return CustomException(message: message);
      }
    } catch (e) {
      return CustomException(message: "Terjadi kesalahan! Silakan coba lagi.");
    }
  }
}
