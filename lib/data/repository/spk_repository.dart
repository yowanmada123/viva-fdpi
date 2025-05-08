import 'package:dartz/dartz.dart';

import '../../models/QC/SPK.dart';
import '../../models/QC/SPR.dart';
import '../../models/checklistItem.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/spk_rest.dart';

class SPKRepository {
  final SPKRest spkRest;

  SPKRepository({required this.spkRest});

  Future<Either<CustomException, List<SPK>>> getSPKList({
    required String idSite,
    required String idCluster,
  }) async {
    return spkRest.getSPKList(idSite: idSite, idCluster: idCluster);
  }

  Future<Either<CustomException, List<SPR>>> getSPRList({
    required String idSite,
    required String idCluster,
  }) async {
    return spkRest.getSPRList(idSite: idSite, idCluster: idCluster);
  }

  Future<Either<CustomException, Map<String, List<ChecklistItem>>>>
  getChecklistItem({required String qcTransId}) async {
    return spkRest.getChecklistItem(qcTransId: qcTransId);
  }

  Future<Either<CustomException, String>> approveChecklist({
    required String qcTransId,
    required String idQcItem,
    required String remark,
  }) async {
    return spkRest.approveChecklist(
      qcTransId: qcTransId,
      idQcItem: idQcItem,
      remark: remark,
    );
  }
}
