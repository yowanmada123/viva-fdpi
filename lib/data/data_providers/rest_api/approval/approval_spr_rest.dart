import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/approval_spr/approval_spr_detail.dart';
import 'package:fdpi_app/models/approval_spr/approve_spr_request.dart';
import 'package:fdpi_app/models/approval_spr/spr.dart';

import '../../../../models/errors/custom_exception.dart';
import '../../../../utils/net_utils.dart';

class ApprovalSprRest {
  Dio http;

  ApprovalSprRest(this.http);

  Future<Either<CustomException, List<Spr>>> getSprList({
    required String idSite,
    required String idCluster,
    required String idHouse,
    String approvalType = "",
    String approvalStatus = "O",
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      // log(
      //   'Request to https://api-fpi.kencana.org/api/fpi/aprv-spr/getListSPR (POST)',
      // );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "aprv": approvalType,
        "status": "O",
      };

      final response = await http.post(
        "api/fpi/aprv-spr/getListSPR",
        data: body,
      );

      log('Response from: $response');

      if (response.statusCode == 200) {
        final data = response.data;

        final List<Spr> items =
            List<Spr>.from(data['data'].map((e) => Spr.fromMap(e))).toList();

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

  Future<Either<CustomException, String>> approvalSpr({
    required ApproveSprRequest data,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spr/approvalSPR (POST)',
      );

      final body = {"id_spr": data.idSpr, "type_aprv": data.typeAprv};

      final response = await http.post(
        "api/fpi/aprv-spr/approvalSPR",
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

  Future<Either<CustomException, String>> rejectSpr({
    required ApproveSprRequest data,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spr/rejectApprove (POST)',
      );

      final body = {"id_spr": data.idSpr, "type_aprv": data.typeAprv};

      final response = await http.post(
        "api/fpi/aprv-spr/rejectApprove",
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

  Future<Either<CustomException, ApprovalSprDetail>> getSprDetail({
    required String idSpr,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/master/getDocumentStatus (POST)',
      );

      final body = {"doc_id": idSpr, "doc_type": "SPR"};

      final response = await http.post(
        "api/fpi/master/getDocumentStatus",
        data: body,
      );

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final data = response.data;

      return Right(ApprovalSprDetail.fromMap(data['data'][0]));
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
