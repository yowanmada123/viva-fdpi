import 'package:http/http.dart';
import 'package:dio/dio.dart' hide Response;

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

  static CustomException parseDioException(DioException e) {
    if (e.response?.statusCode == 401) {
      return UnauthorizedException(message: e.toString());
    } else if (e.response?.statusCode == 403) {
      return ForbiddenException(message: e.toString());
    } else if (e.response?.statusCode == 404) {
      return NotFoundException(message: e.toString());
    } else {
      return CustomException(message: e.toString());
    }
  }
}
