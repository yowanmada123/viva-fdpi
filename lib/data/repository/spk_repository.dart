import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/checklistSprProgress.dart';

import '../../models/QC/SPK.dart';
import '../../models/QC/SPR.dart';
import '../../models/checklistSpkProgress.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/spk_rest.dart';

class SPKRepository {
  final SPKRest spkRest;

  SPKRepository({required this.spkRest});

  Future<Either<CustomException, List<SPK>>> getSPKList({
    required String idSite,
    required String idCluster,
    required String idHouse,
  }) async {
    return spkRest.getSPKList(
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
    required MultipartFile? fileImage,
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
}
