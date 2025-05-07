import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/checklistItem.dart';
import 'package:fdpi_app/utils/grouping_item.dart';

import '../../../models/errors/custom_exception.dart';
import '../../../utils/net_utils.dart';

class SPKRest {
  Dio http;

  SPKRest(this.http);

  Future<Either<CustomException, Map<String, List<ChecklistItem>>>>
  getChecklistItem({required String idHouse, required String clType}) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/getCheckList (POST)',
      );

      final body = {"id_house": idHouse, "cl_type": clType};

      final response = await http.post(
        "api/fpi/checklist/getCheckList",
        data: body,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final data = response.data;

        final List<ChecklistItem> items = List<ChecklistItem>.from(
          data['data'].map((e) => ChecklistItem.fromMap(e)),
        );

        final Map<String, List<ChecklistItem>> checklistItem = groupItemsBy(
          items,
          (ChecklistItem e) => e.comDesc,
        );

        return Right(checklistItem);
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
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/aprvCheckList (POST)',
      );

      final body = {
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "remark": remark,
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
