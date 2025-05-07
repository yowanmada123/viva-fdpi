import 'package:dartz/dartz.dart';

import '../../models/checklistItem.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/spk_rest.dart';

class SPKRepository {
  final SPKRest spkRest;

  SPKRepository({required this.spkRest});

  Future<Either<CustomException, Map<String, List<ChecklistItem>>>>
  getChecklistItem({required String idHouse, required String clType}) async {
    return spkRest.getChecklistItem(idHouse: idHouse, clType: clType);
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
