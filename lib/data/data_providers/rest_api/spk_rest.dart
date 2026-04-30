import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/QC/Cleaning.dart';
import 'package:fdpi_app/models/checklistCleaningProgress.dart';

import '../../../models/QC/SPK.dart';
import '../../../models/QC/SPR.dart';
import '../../../models/QC/detail_approve.dart';
import '../../../models/attachment.dart';
import '../../../models/checklistItem.dart';
import '../../../models/checklistSpkProgress.dart';
import '../../../models/checklistSprProgress.dart';
import '../../../models/errors/custom_exception.dart';
import '../../../models/fdpi/house_item_spk.dart';
import '../../../models/master/vendor.dart';
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
        'Request to ${http.options.baseUrl}fpi/checklist/getCheckListHdr (POST)',
      );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "doc_type": "SPR",
      };

      log("Request body getSPRList: $body");

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
      log("This is the exception A : $e");
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      log("This is the exception B: $e");
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      log("This is the exception C : $e");
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<Cleaning>>> getCleaningList({
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}fpi/checklist/getCheckListHdr (POST)',
      );

      final body = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "doc_type": "KK",
      };

      log("Request body getCleaningListHdr: $body");

      final response = await http.post(
        "api/fpi/checklist/getCheckListHdr",
        data: body,
      );

      log('Response getCleaningListHdr: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        final List<Cleaning> items =
            List<Cleaning>.from(
              data['data'].map((e) => Cleaning.fromMap(e)),
            ).toList();

        return Right(items);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      log("This is the exception A : $e");
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      log("This is the exception B: $e");
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      log("This is the exception C : $e");
      return Left(CustomException(message: e.toString()));
    }
  }

  // Future<Either<CustomException, List<SPK>>> getSPKList({
  Future<Either<CustomException, List<SPKGroupedByClusterHome>>> getSPKList({
    required String idVendor,
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}api/fpi/checklist/getCheckListHdr (POST)',
      );

      final body = {
        "vendor_id": idVendor,
        "id_site": idSite,
        "id_cluster": idCluster,
        "id_house_item": idHouse,
        "doc_type": "SPK",
      };

      log("Request body getSPKList: $body");

      final response = await http.post(
        "api/fpi/checklist/getCheckListHdr",
        data: body,
      );

      log('Response getSPKList: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        final List<SPK> items =
            List<SPK>.from(data['data'].map((e) => SPK.fromMap(e))).toList();

        List<SPKGroupedByClusterHome> groupedItems = [];

        Map<String, Map<String, List<SPK>>> groupedMap = {};

        for (var spk in items) {
          groupedMap.putIfAbsent(spk.idCluster, () => {});

          groupedMap[spk.idCluster]!.putIfAbsent(spk.idHouse, () => []);

          groupedMap[spk.idCluster]![spk.idHouse]!.add(spk);
        }

        groupedMap.forEach((clusterId, houses) {
          houses.forEach((houseId, spks) {
            groupedItems.add(
              SPKGroupedByClusterHome(
                idCluster: clusterId,
                clusterName: spks.first.clusterName,
                idHouse: houseId,
                houseName: spks.first.houseName,
                spks: spks,
              ),
            );
          });
        });

        print("groupedItems: $groupedItems");

        return Right(groupedItems);
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
        'Request to ${http.options.baseUrl}fpi/checklist/getCheckListDtl (POST)',
      );

      final body = {"qc_trans_id": qcTransId};

      final response = await http.post(
        "api/fpi/checklist/getCheckListDtl",
        data: body,
      );

      log('Response getChecklistItem: ${response.data}');

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
        'Request to ${http.options.baseUrl}fpi/checklist/getCheckListDtl (POST)',
      );

      final body = {"qc_trans_id": qcTransId};

      log('Request body getSprChecklistItem: $body');

      final response = await http.post(
        "api/fpi/checklist/getCheckListDtl",
        data: body,
      );

      log('Response getSprChecklistItem: ${response.data}');
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

  Future<Either<CustomException, List<ChecklistCleaningItem>>>
  getCleaningChecklistItem({required String qcTransId}) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}fpi/checklist/getCheckListDtl (POST)',
      );

      final body = {"qc_trans_id": qcTransId};

      final response = await http.post(
        "api/fpi/checklist/getCheckListDtl",
        data: body,
      );

      log('Response getCleaningChecklistItem: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;

        List<ChecklistCleaningItem> allItems = [];

        for (final company in data['data']) {
          final categories = company['categories'] as List<dynamic>;

          for (final category in categories) {
            final items = category['items'] as List<dynamic>;

            // Add each item with company and category info
            for (final item in items) {
              allItems.add(ChecklistCleaningItem.fromMap(item));
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

      log('Response getSpkChecklistItem: ${response.data}');

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
    required List<Attachment>? fileImage,
    required String longitude,
    required String latitude,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      http.options.contentType = Headers.formUrlEncodedContentType;
      // http.options.contentType = 'multipart/form-data';
      log(
        'Request to https://v2.kencana.org/api/fpi/checklist/aprvCheckList (POST)',
      );

      final fileAttachmentList = fileImage?.map((e) => e.file).toList();

      final files =
          fileAttachmentList?.map((file) async {
            return await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            );
          }).toList();

      // log("fileAttachmentList: $fileAttachmentList");
      log("Attachments: ${fileAttachmentList?.map((e) => e.path)}");

      final FormData formData = FormData.fromMap({
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "id_work": idWork,
        "remark": remark,
        "img[]": files != null ? await Future.wait(files) : [],
        // "img[]": fileAttachmentList,
        "longitude": longitude,
        "latitude": latitude,
      });

      log("FormData fields: ${formData.fields}");

      // log("Request body: $formData");

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

        log("Response approveChecklist: $data");
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
        'Request to ${http.options.baseUrl}api/fpi/checklist/getCheckListHouse (POST)',
      );

      final payload = {
        "id_site": idSite,
        "id_cluster": idCluster,
        "active_flag": activeFlag,
        "doc_type": docType,
      };

      log("Request body getHouseWithSpk: $payload");

      final response = await http.post(
        "api/fpi/checklist/getCheckListHouse",
        data: payload,
      );

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      log("Response getHouseWithSpk: ${response.data}");

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

  Future<Either<CustomException, DetailApproveResponse>> getDetailApproveDetail(
    DetailApproveRequest detailApproveRequest,
  ) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}api/fpi/checklist/getAprvDtl (POST)',
      );

      final payload = {
        "qc_trans_id": detailApproveRequest.qcTransId,
        "id_qc_item": detailApproveRequest.idQcItem,
        "id_work": detailApproveRequest.idWork,
      };

      final response = await http.post(
        "api/fpi/checklist/getAprvDtl",
        data: payload,
      );

      log("Response getDetailApproveDetail: ${response.data}");

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final data = response.data;

      final result = DetailApproveResponse.fromMap(data['data'][0]);

      return Right(result);
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, String>> unapproveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String idWork,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}api/fpi/checklist/cancelAprvCheckList  (POST)',
      );

      final payload = {
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "id_work": idWork,
      };

      final response = await http.post(
        "api/fpi/checklist/cancelAprvCheckList",
        data: payload,
      );

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final result = "Success";

      return Right(result);
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, String>> updateApproveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String idWork,
    required String remark,
    required List<Attachment>? fileImage,
    required List<String> deleteImage,
    required String longitude,
    required String latitude,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}api/fpi/checklist/updateAprvCheckList (POST)',
      );

      final payload = {
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "id_work": idWork,
        "remark": remark,
        "img[]": fileImage?.map((e) => e.file).toList(),
        "removed_file": deleteImage,
        "longitude": longitude,
        "latitude": latitude,
      };

      final response = await http.post(
        "api/fpi/checklist/updateAprvCheckList",
        data: payload,
      );

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final result = "Success";

      return Right(result);
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, String>> updateRemarkChecklist({
    required String qcTransId,
    required String idQcItem,
    required String idWork,
    required String remark,
    required List<Attachment>? fileImage,
    required List<String> deleteImage,
    required String longitude,
    required String latitude,
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to ${http.options.baseUrl}api/fpi/checklist/updateRemarkChecklist (POST)',
      );

      final payload = {
        "qc_trans_id": qcTransId,
        "id_qc_item": idQcItem,
        "id_work": idWork,
        "remark": remark,
        "img[]": fileImage?.map((e) => e.file).toList(),
        "removed_file": deleteImage,
        "longitude": longitude,
        "latitude": latitude,
      };

      log("Request body updateRemarkChecklist: $payload");

      final response = await http.post(
        "api/fpi/checklist/updateRemarkCheckList",
        data: payload,
      );

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final result = "Success";

      return Right(result);
    } on DioException catch (e) {
      log("This is the DioException A: $e");
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      log("This is the DioException B: $e");

      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      log("This is the DioException C: $e");

      return Left(CustomException(message: e.toString()));
    }
  }
}
