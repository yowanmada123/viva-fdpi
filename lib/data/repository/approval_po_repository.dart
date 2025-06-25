import 'package:dartz/dartz.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_po.dart';

import '../../models/approval_po/approval_po.dart';
import '../../models/errors/custom_exception.dart';

class ApprovalPORepository {
  final ApprovalPORest approvalPORest;

  ApprovalPORepository({required this.approvalPORest});

  Future<Either<CustomException, List<ApprovalPo>>> getPOList() async {
    return approvalPORest.getPOList();
  }

  Future<Either<CustomException, String>> approvalPO({
    required String poId,
    required String typeAprv,
  }) async {
    return approvalPORest.approvalPO(poId: poId, typeAprv: typeAprv);
  }

  Future<Either<CustomException, String>> rejectPO({
    required String poId,
    required String typeAprv,
  }) async {
    return approvalPORest.rejectPO(poId: poId, typeAprv: typeAprv);
  }
}
