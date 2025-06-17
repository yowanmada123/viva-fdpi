import 'package:dartz/dartz.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_spb_rest.dart';

import '../../models/approval_spb/approve_spb_request.dart';
import '../../models/approval_spb/spb.dart';
import '../../models/errors/custom_exception.dart';

class ApprovalSpbRepository {
  final ApprovalSpbRest approvalSpbRest;

  ApprovalSpbRepository({required this.approvalSpbRest});

  Future<Either<CustomException, List<Spb>>> getSpbList({
    required String idSite,
    required String idCluster,
    required String idHouse,
    String approvalType = "",
    String approvalStatus = "",
  }) async {
    return approvalSpbRest.getSpbList(
      idSite: idSite,
      idCluster: idCluster,
      idHouse: idHouse,
      approvalType: approvalType,
      approvalStatus: approvalStatus,
    );
  }

  Future<Either<CustomException, String>> approvalSpb({
    required ApproveSpbRequest data,
  }) async {
    return approvalSpbRest.approvalSpb(data: data);
  }

  Future<Either<CustomException, String>> rejectSpb({
    required ApproveSpbRequest data,
  }) async {
    return approvalSpbRest.rejectSpb(data: data);
  }
}
