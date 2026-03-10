import 'package:dartz/dartz.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_spr_rest.dart';
import 'package:fdpi_app/models/approval_spr/approval_spr_detail.dart';
import 'package:fdpi_app/models/approval_spr/approve_spr_request.dart';
import 'package:fdpi_app/models/approval_spr/spr.dart';

import '../../models/errors/custom_exception.dart';

class ApprovalSprRepository {
  final ApprovalSprRest approvalSprRest;

  ApprovalSprRepository({required this.approvalSprRest});

  Future<Either<CustomException, List<Spr>>> getSprList({
    required String idSite,
    required String idCluster,
    required String idHouse,
    String approvalType = "",
    String approvalStatus = "",
  }) async {
    return approvalSprRest.getSprList(
      idSite: idSite,
      idCluster: idCluster,
      idHouse: idHouse,
      approvalType: approvalType,
      approvalStatus: approvalStatus,
    );
  }

  Future<Either<CustomException, String>> approvalSpr({
    required ApproveSprRequest data,
  }) async {
    return approvalSprRest.approvalSpr(data: data);
  }

  Future<Either<CustomException, String>> rejectSpr({
    required ApproveSprRequest data,
  }) async {
    return approvalSprRest.rejectSpr(data: data);
  }

  Future<Either<CustomException, ApprovalSprDetail>> getSprDetail({
    required String idSpr,
  }) async {
    return approvalSprRest.getSprDetail(idSpr: idSpr);
  }
}
