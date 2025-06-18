import 'package:dartz/dartz.dart';

import '../../models/approval_spk/approval_spk.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/approval/approval_spk_rest.dart';

class ApprovalSpkRepository {
  final ApprovalSpkRest approvalSpkRest;

  ApprovalSpkRepository({required this.approvalSpkRest});

  Future<Either<CustomException, List<ApprovalSpk>>> getSpkList({
    required String idSite,
    required String idCluster,
    required String idHouse,
    String approvalType = "",
    String approvalStatus = "",
  }) async {
    return approvalSpkRest.getSpkList(
      idSite: idSite,
      idCluster: idCluster,
      idHouse: idHouse,
      approvalType: approvalType,
      approvalStatus: approvalStatus,
    );
  }

  Future<Either<CustomException, String>> approvalSpk({
    required String idSpk,
    required String typeAprv,
    required String spkType,
  }) async {
    return approvalSpkRest.approvalSpk(
      idSpk: idSpk,
      typeAprv: typeAprv,
      spkType: spkType,
    );
  }

  Future<Either<CustomException, String>> rejectSpk({
    required String idSpk,
    required String typeAprv,
    required String spkType,
  }) async {
    return approvalSpkRest.rejectSpk(
      idSpk: idSpk,
      typeAprv: typeAprv,
      spkType: spkType,
    );
  }
}
