import 'package:dio/dio.dart';

class Environment {
  static const apiPath = 'https://v3.kencana.org/';
  static BaseOptions dioBaseOptions = BaseOptions(
    baseUrl: apiPath,
    connectTimeout: Duration(milliseconds: 10000),
    receiveTimeout: Duration(milliseconds: 10000),
    contentType: 'application/json',
  );
}

class FpiEnvironment {
  static const apiPath = 'https://api-fpi.kencana.org/';
  // static const apiPath = 'http://127.0.0.1:8001/';
  // static const apiPath = 'http://10.65.65.25:8001/';
  static BaseOptions dioBaseOptions = BaseOptions(
    baseUrl: apiPath,
    connectTimeout: Duration(milliseconds: 10000),
    receiveTimeout: Duration(milliseconds: 10000),
    contentType: 'application/json',
  );
}
