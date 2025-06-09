import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/checklistSpkProgress.dart';
import 'package:fdpi_app/models/master/vendor.dart';

import '../../../models/QC/SPK.dart';
import '../../../models/QC/SPR.dart';
import '../../../models/checklistItem.dart';
import '../../../models/checklistSprProgress.dart';
import '../../../models/errors/custom_exception.dart';
import '../../../models/fdpi/house_item_spk.dart';
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
    required String idVendor,
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
        "id_vendor": idVendor,
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

  Future<Either<CustomException, List<ChecklistSprItem>>> getSprChecklistItem({
    required String qcTransId,
  }) async {
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
        final data = response.data;

        List<ChecklistSprItem> allItems = [];

        for (final company in data['data']) {
          final categories = company['categories'] as List<dynamic>;

          for (final category in categories) {
            final items = category['items'] as List<dynamic>;

            // Add each item with company and category info
            for (final item in items) {
              allItems.add(ChecklistSprItem.fromMap(item));
            }
          }
        }

        return Right(allItems);
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

  Future<Either<CustomException, List<ChecklistSpkProgress>>>
  getSpkChecklistItem({required String qcTransId}) async {
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
        final data = response.data;

        final result = List<ChecklistSpkProgress>.from(
          data['data'].map((e) => ChecklistSpkProgress.fromMap(e)),
        );

        return Right(result);
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
    required String idWork,
    required MultipartFile? fileImage,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      http.options.contentType = Headers.formUrlEncodedContentType;
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/aprvCheckList (POST)',
      );

      final FormData formData = FormData.fromMap({
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "id_work": idWork,
        "remark": remark,
        "img": fileImage,
      });

      log("Request body: $formData");

      // final body = {
      //   "qc_trans_id": qcTransId,
      //   "id_qc_item": idQcItem,
      //   "id_work": idWork,
      //   "remark": remark,
      //   "img": fileImage,
      // };

      // log("Request body: $body");

      final response = await http.post(
        "api/fpi/checklist/aprvCheckList",
        data: formData,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        log("Success");
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

  Future<Either<CustomException, List<Vendor>>> getVendorWithSpk() async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/checklist/getCheckListVendor (POST)',
      );

      final response = await http.post("api/fpi/checklist/getCheckListVendor");

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final data = response.data;

      final result = List<Vendor>.from(
        data['data'].map((e) => Vendor.fromMap(e)),
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<HouseItemSpk>>> getHouseWithSpk({
    required String idSite,
    required String idCluster,
    required String docType,
    String activeFlag = "Y",
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/checklist/getCheckListHouse (POST)',
      );

      final payload = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "active_flag": activeFlag,
        "doc_type": docType,
      };

      final response = await http.post(
        "api/fpi/checklist/getCheckListHouse",
        data: payload,
      );

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final data = response.data;

      final result = List<HouseItemSpk>.from(
        data['data'].map((e) => HouseItemSpk.fromMap(e)),
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
