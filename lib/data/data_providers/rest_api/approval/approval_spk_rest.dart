import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../models/approval_spk/approval_spk.dart';
import '../../../../models/errors/custom_exception.dart';
import '../../../../utils/net_utils.dart';

class ApprovalSpkRest {
  Dio http;

  ApprovalSpkRest(this.http);

  Future<Either<CustomException, List<ApprovalSpk>>> getSpkList({
    required String idSite,
    required String idCluster,
    required String idHouse,
    String approvalType = "",
    String approvalStatus = "O",
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spk/getListSPKMobile (POST)',
      );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "aprv": approvalType,
        "status": "O",
      };

      final response = await http.post(
        "api/fpi/aprv-spk/getListSPK",
        data: body,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final List<ApprovalSpk> items =
            List<ApprovalSpk>.from(
              data['data'].map((e) => ApprovalSpk.fromMap(e)),
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

  Future<Either<CustomException, String>> approvalSpk({
    required String idSpk,
    required String typeAprv,
    required String spkType,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spk/approvalSPK (POST)',
      );

      final body = {
        "id_spk": idSpk,
        "type_aprv": typeAprv,
        "type_spk": spkType,
      };

      final response = await http.post(
        "api/fpi/aprv-spk/approvalSPK",
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

  Future<Either<CustomException, String>> rejectSpk({
    required String idSpk,
    required String typeAprv,
    required String spkType,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/aprv-spk/rejectApprove (POST)',
      );

      final body = {
        "id_spk": idSpk,
        "type_aprv": typeAprv,
        "type_spk": spkType,
      };

      final response = await http.post(
        "api/fpi/aprv-spk/rejectApprove",
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
