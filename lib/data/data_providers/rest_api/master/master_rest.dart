import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../models/bank.dart';
import '../../../../models/errors/custom_exception.dart';
import '../../../../models/master/loan_type.dart';
import '../../../../models/master/vendor.dart';
import '../../../../utils/net_utils.dart';

class MasterRest {
  Dio dio;

  MasterRest(this.dio);

  Future<Either<CustomException, List<Bank>>> getBank() async {
    try {
      dio.options.headers['requiresToken'] = true;
      log(
        'Request to dios://v2.kencana.org/api/fpi/master/getbankaccount (POST)',
      );
      final response = await dio.post("api/fpi/master/getbankaccount");
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final banks = List<Bank>.from(
          body['data'].map((e) {
            return Bank.fromMap(e);
          }),
        );
        return Right(banks);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<Vendor>>> getVendor() async {
    try {
      dio.options.headers['requiresToken'] = true;
      log('Request to dios://v2.kencana.org/api/fpi/master/getVendor (POST)');
      final response = await dio.post("api/fpi/master/getVendor");
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final vendors = List<Vendor>.from(
          body['data'].map((e) {
            return Vendor.fromMap(e);
          }),
        );
        return Right(vendors);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<LoanType>>> getLoanType() async {
    try {
      dio.options.headers['requiresToken'] = true;
      log(
        'Request to dios://v2.kencana.org/api/fpi/master/getApplConstant (POST)',
      );

      final payload = {"key_code": "KASBON"};

      final response = await dio.post(
        "api/fpi/master/getApplConstant",
        data: payload,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final loadTypes = List<LoanType>.from(
          body['data'].map((e) {
            return LoanType.fromMap(e);
          }),
        );
        return Right(loadTypes);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
