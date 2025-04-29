import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../models/bank.dart';
import '../../../../models/errors/custom_exception.dart';
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
}
