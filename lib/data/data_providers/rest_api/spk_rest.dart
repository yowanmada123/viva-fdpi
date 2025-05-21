import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../models/QC/SPK.dart';
import '../../../models/QC/SPR.dart';
import '../../../models/checklistItem.dart';
import '../../../models/errors/custom_exception.dart';
import '../../../utils/grouping_item.dart';
import '../../../utils/net_utils.dart';

class SPKRest {
  Dio http;

  SPKRest(this.http);

  Future<Either<CustomException, List<SPR>>> getSPRList({
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/getCheckListHdr (POST)',
      );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "doc_type": "SPR",
      };

      final response = await http.post(
        "api/fpi/checklist/getCheckListHdr",
        data: body,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final data = response.data;

        final List<SPR> items =
            List<SPR>.from(data['data'].map((e) => SPR.fromMap(e))).toList();

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

  Future<Either<CustomException, List<SPK>>> getSPKList({
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/getCheckListHdr (POST)',
      );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "doc_type": "SPK",
      };

      final response = await http.post(
        "api/fpi/checklist/getCheckListHdr",
        data: body,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final data = response.data;

        final List<SPK> items =
            List<SPK>.from(data['data'].map((e) => SPK.fromMap(e))).toList();

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

  Future<Either<CustomException, Map<String, Map<String, dynamic>>>>
  getChecklistItem({required String qcTransId}) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/getCheckListDtl (POST)',
      );

      final body = {"qc_trans_id": qcTransId};

      final response = await http.post(
        "api/fpi/checklist/getCheckListDtl",
        data: body,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final data = response.data;

        final List<ChecklistItem> items = List<ChecklistItem>.from(
          data['data'].map((e) => ChecklistItem.fromMap(e)),
        );

        final Map<String, Map<String, dynamic>> grouped = groupItemsWithStats(
          items: items,
          keySelector: (item) => item.comDesc,
          isApproved: (item) => item.aprvBy.isNotEmpty,
        );

        return Right(grouped);
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

  Future<Either<CustomException, String>> approveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String remark,
    required String imgBase64,
    required String idWork,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/aprvCheckList (POST)',
      );

      final body = {
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "id_work": idWork,
        "remark": remark,
        "img": imgBase64,
      };

      final response = await http.post(
        "api/fpi/checklist/aprvCheckList",
        data: body,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final data = response.data;

        return Right(data['message'] ?? "Approve Success");
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
