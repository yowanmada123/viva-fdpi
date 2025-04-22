import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String? message;
  final int? errorCode;

  const CustomException({this.message, this.errorCode});

  @override
  String toString() {
    return message ?? "Unknown Error";
  }

  @override
  List<Object?> get props => [message];
}

class NotFoundException extends CustomException {
  const NotFoundException({super.message, super.errorCode = 404});
}

class ForbiddenException extends CustomException {
  const ForbiddenException({super.message, super.errorCode = 403});
}

class UnauthorizedException extends CustomException {
  const UnauthorizedException({super.message, super.errorCode = 401});
}
