import 'package:dartz/dartz.dart';

import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/city.dart';
import '../../models/fdpi/house.dart';
import '../../models/fdpi/province.dart';
import '../../models/fdpi/residence.dart';
import '../data_providers/rest_api/fdpi/fdpi_rest.dart';

class FdpiRepository {
  final FdpiRest fdpiRest;

  FdpiRepository({required this.fdpiRest});

  Future<Either<CustomException, List<Province>>> getProvinces() async {
    return fdpiRest.getProvinces();
  }

  Future<Either<CustomException, List<City>>> getCities(String id) async {
    return fdpiRest.getCities(id);
  }

  Future<Either<CustomException, List<Residence>>> getResidences(
    String idProv,
    String idCity,
    String status,
  ) async {
    return fdpiRest.getResidences(idProv, idCity, status);
  }

  Future<Either<CustomException, List<House>>> getHouses(
    String idCluster,
  ) async {
    return fdpiRest.getHouses(idCluster);
  }
}
