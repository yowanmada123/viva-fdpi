import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../models/approval_spb/approve_spb_request.dart';
import '../../../../models/approval_spb/spb.dart';
import '../../../../models/errors/custom_exception.dart';
import '../../../../utils/net_utils.dart';

class ApprovalSpbRest {
  Dio http;

  ApprovalSpbRest(this.http);

  Future<Either<CustomException, List<Spb>>> getSpbList({
    required String idSite,
    required String idCluster,
    required String idHouse,
    String approvalType = "",
    String approvalStatus = "",
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spb/getListSPB (POST)',
      );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "aprv": approvalType,
        "status": approvalStatus,
      };

      final response = await http.post(
        "api/fpi/aprv-spb/getListSPB",
        data: body,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final List<Spb> items =
            List<Spb>.from(data['data'].map((e) => Spb.fromMap(e))).toList();

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

  Future<Either<CustomException, String>> approvalSpb({
    required ApproveSpbRequest data,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spb/approvalSPB (POST)',
      );

      final body = {"id_spb": data.idSpb, "type_aprv": data.typeAprv};

      final response = await http.post(
        "api/fpi/aprv-spb/approvalSPB",
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

  Future<Either<CustomException, String>> rejectSpb({
    required ApproveSpbRequest data,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spb/rejectApprove (POST)',
      );

      final body = {"id_spb": data.idSpb, "type_aprv": data.typeAprv};

      final response = await http.post(
        "api/fpi/aprv-spb/rejectApprove",
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
