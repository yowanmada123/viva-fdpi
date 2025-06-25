import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../models/approval_po/approval_po.dart';
import '../../../../models/errors/custom_exception.dart';
import '../../../../utils/net_utils.dart';

class ApprovalPORest {
  Dio http;

  ApprovalPORest(this.http);

  Future<Either<CustomException, List<ApprovalPo>>> getPOList() async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/prpo/getList (POST)');

      final body = {"tr_type": "PO"};

      final response = await http.post("api/fpi/prpo/getList", data: body);

      if (response.statusCode == 200) {
        final data = response.data;

        final List<ApprovalPo> items =
            List<ApprovalPo>.from(
              data['data'].map((e) => ApprovalPo.fromMap(e)),
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

  Future<Either<CustomException, String>> approvalPO({
    required String poId, // poId
    required String typeAprv, // Approve1 atau Approve2
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/prpo/approve (POST)');

      final body = {"tr_id ": poId, "tr_type": "PO", "type_aprv": typeAprv};

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

  Future<Either<CustomException, String>> rejectPO({
    required String poId, // poId
    required String typeAprv, // Approve1 atau Approve2
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://api-fpi.kencana.org/api/fpi/prpo/cancel (POST)');

      final body = {"tr_id ": poId, "tr_type": "PO", "type_aprv": typeAprv};

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
