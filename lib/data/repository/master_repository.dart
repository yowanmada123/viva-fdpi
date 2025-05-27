import 'package:dartz/dartz.dart';

import '../../models/bank.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/master/loan_type.dart';
import '../../models/master/vendor.dart';
import '../data_providers/rest_api/master/master_rest.dart';

class MasterRepository {
  final MasterRest masterRest;

  MasterRepository({required this.masterRest});

  Future<Either<CustomException, List<Bank>>> getBank() async {
    return masterRest.getBank();
  }

  Future<Either<CustomException, List<Vendor>>> getVendor() async {
    return masterRest.getVendor();
  }

  Future<Either<CustomException, List<LoanType>>> getLoanType() async {
    return masterRest.getLoanType();
  }
}
