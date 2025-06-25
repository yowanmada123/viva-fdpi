import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/approval_pr/approval_pr.dart';

import '../../../../models/errors/custom_exception.dart';
import '../../../../utils/net_utils.dart';

class ApprovalPRRest {
  Dio http;

  ApprovalPRRest(this.http);

  Future<Either<CustomException, List<ApprovalPR>>> getPRList() async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/prpo/getList (PRST)');

      final body = {"tr_type": "PR"};

      final response = await http.post("api/fpi/prpo/getList", data: body);

      if (response.statusCode == 200) {
        final data = response.data;

        final List<ApprovalPR> items =
            List<ApprovalPR>.from(
              data['data'].map((e) => ApprovalPR.fromMap(e)),
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

  Future<Either<CustomException, String>> approvalPR({
    required String prId, // prId
    required String typeAprv, // Approve1 atau Approve2
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/prpo/approve (PRST)');

      final body = {"tr_id": prId, "tr_type": "PR", "type_aprv": typeAprv};

      final response = await http.post("api/fpi/prpo/approve", data: body);

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

  Future<Either<CustomException, String>> rejectPR({
    required String prId, // prId
    required String typeAprv, // Approve1 atau Approve2
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/prpo/cancel (PRST)');

      final body = {"tr_id": prId, "tr_type": "PR", "type_aprv": typeAprv};

      final response = await http.post("api/fpi/prpo/cancel", data: body);

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
