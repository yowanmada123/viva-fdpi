import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/approval_loan/approval_loan.dart';

import '../../../../models/errors/custom_exception.dart';
import '../../../../utils/net_utils.dart';

class ApprovalLoanRest {
  Dio http;

  ApprovalLoanRest(this.http);

  Future<Either<CustomException, List<ApprovalLoan>>> getLoanList({
    required String vendorId,
    String approvalType = "",
    String approvalStatus = "O",
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/kasbon/getKasbonMobile (POST)',
      );

      final body = {
        "vendor_id": vendorId,
        "aprv": approvalType,
        "status": approvalStatus,
      };

      final response = await http.post(
        "api/fpi/kasbon/getKasbonMobile",
        data: body,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final List<ApprovalLoan> items =
            List<ApprovalLoan>.from(
              data['data'].map((e) => ApprovalLoan.fromMap(e)),
            ).toList();

        return Right(items);
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

  Future<Either<CustomException, String>> approvalLoan({
    required String trId,
    required String typeAprv
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/kasbon/approvalKasbon (POST)');

      final body = {
        "tr_id": trId,
        "type_aprv": typeAprv,
      };

      final response = await http.post(
        "api/fpi/kasbon/aprvKasbon",
        data: body,
      );

      if (response.statusCode == 200) {
        return Right("Successfully approved");
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

  Future<Either<CustomException, String>> rejectLoan({
    required String trId,
    required String typeAprv,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/kasbon/rjctKasbon (POST)',
      );

      final body = {
        "tr_id": trId,
        "type_aprv": typeAprv,
      };

      final response = await http.post(
        "api/fpi/kasbon/rjctKasbon",
        data: body,
      );

      if (response.statusCode == 200) {
        return Right("Successfully rejected");
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
