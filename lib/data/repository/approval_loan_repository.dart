import 'package:dartz/dartz.dart';

import '../../models/approval_loan/approval_loan.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/approval/approval_loan_rest.dart';

class ApprovalLoanRepository {
  final ApprovalLoanRest approvalLoanRest;

  ApprovalLoanRepository({required this.approvalLoanRest});

  Future<Either<CustomException, List<ApprovalLoan>>> getLoanList({
    required String vendorId,
    String approvalType = "",
    String approvalStatus = "",
  }) async {
    return approvalLoanRest.getLoanList(
      vendorId: vendorId,
      approvalType: approvalType,
      approvalStatus: approvalStatus,
    );
  }

  Future<Either<CustomException, String>> approvalLoan({
    required String trId,
    required String typeAprv,
  }) async {
    return approvalLoanRest.approvalLoan(trId: trId, typeAprv: typeAprv);
  }

  Future<Either<CustomException, String>> rejectLoan({
    required String trId,
    required String typeAprv,
  }) async {
    return approvalLoanRest.rejectLoan(trId: trId, typeAprv: typeAprv);
  }
}
