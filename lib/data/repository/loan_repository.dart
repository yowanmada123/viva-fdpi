import 'package:dartz/dartz.dart';

import '../../models/errors/custom_exception.dart';
import '../../models/loan/vendor_spk.dart';
import '../data_providers/rest_api/loan/loan_rest.dart';

class LoanRepository {
  final LoanRest loanRest;

  LoanRepository({required this.loanRest});

  Future<Either<CustomException, List<VendorSpk>>> getVendorSpk({
    required String vendorId,
    String? activeFlag,
  }) async {
    return loanRest.getVendorSpk(vendorId: vendorId, activeFlag: activeFlag);
  }

  Future<Either<CustomException, String>> storeLoan({
    required String dateLoan,
    required String loanTypeId,
    required String amount,
    required String vendorId,
    required String remark,
    required String spkId,
  }) async {
    return loanRest.storeLoan(
      dateLoan: dateLoan,
      loanTypeId: loanTypeId,
      amount: amount,
      vendorId: vendorId,
      remark: remark,
      spkId: spkId,
    );
  }
}
