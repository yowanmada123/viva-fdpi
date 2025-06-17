import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/QC/detail_approve.dart';
import 'package:fdpi_app/models/attachment.dart';

import '../../models/QC/SPK.dart';
import '../../models/QC/SPR.dart';
import '../../models/checklistSpkProgress.dart';
import '../../models/checklistSprProgress.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/house_item_spk.dart';
import '../../models/master/vendor.dart';
import '../data_providers/rest_api/spk_rest.dart';

class SPKRepository {
  final SPKRest spkRest;

  SPKRepository({required this.spkRest});

  Future<Either<CustomException, List<SPK>>> getSPKList({
    required String idVendor,
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    return spkRest.getSPKList(
      idVendor: idVendor,
      idSite: idSite,
      idCluster: idCluster,
      idHouse: idHouse,
    );
  }

  Future<Either<CustomException, List<SPR>>> getSPRList({
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    return spkRest.getSPRList(
      idSite: idSite,
      idCluster: idCluster,
      idHouse: idHouse,
    );
  }

  Future<Either<CustomException, List<ChecklistSpkProgress>>>
  getSpkChecklistItem({required String qcTransId}) async {
    return spkRest.getSpkChecklistItem(qcTransId: qcTransId);
  }

  Future<Either<CustomException, List<ChecklistSprItem>>> getSprChecklistItem({
    required String qcTransId,
  }) async {
    return spkRest.getSprChecklistItem(qcTransId: qcTransId);
  }

  Future<Either<CustomException, Map<String, Map<String, dynamic>>>>
  getChecklistItem({required String qcTransId}) async {
    return spkRest.getChecklistItem(qcTransId: qcTransId);
  }

  Future<Either<CustomException, String>> approveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String remark,
    required List<Attachment>? fileImage,
    required String idWork,
  }) async {
    return spkRest.approveChecklist(
      qcTransId: qcTransId,
      idQcItem: idQcItem,
      remark: remark,
      fileImage: fileImage,
      idWork: idWork,
    );
  }

  Future<Either<CustomException, List<Vendor>>> getVendorWithSpk() async {
    return spkRest.getVendorWithSpk();
  }

  Future<Either<CustomException, List<HouseItemSpk>>> getHouseWithSpk({
    required String idSite,
    required String idCluster,
    required String docType,
    String activeFlag = "Y",
  }) async {
    return spkRest.getHouseWithSpk(
      idSite: idSite,
      idCluster: idCluster,
      docType: docType,
      activeFlag: activeFlag,
    );
  }

  Future<Either<CustomException, DetailApproveResponse>> getDetailApproveDetail(
    DetailApproveRequest detailApproveRequest,
  ) async {
    return spkRest.getDetailApproveDetail(detailApproveRequest);
  }

  Future<Either<CustomException, String>> unapproveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String idWork,
  }) async {
    return spkRest.unapproveChecklist(
      qcTransId: qcTransId,
      idQcItem: idQcItem,
      idWork: idWork,
    );
  }

  Future<Either<CustomException, String>> updateApproveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String idWork,
    required String remark,
    required List<Attachment>? fileImage,
    required List<String> deleteImage,
  }) async {
    return spkRest.updateApproveChecklist(
      qcTransId: qcTransId,
      idQcItem: idQcItem,
      idWork: idWork,
      remark: remark,
      fileImage: fileImage,
      deleteImage: deleteImage,
    );
  }
}
