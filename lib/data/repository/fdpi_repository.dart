import 'package:dartz/dartz.dart';

import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/city.dart';
import '../../models/fdpi/house.dart';
import '../../models/fdpi/house_type.dart';
import '../../models/fdpi/province.dart';
import '../../models/fdpi/residence.dart';
import '../../models/fdpi/site.dart';
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

  Future<Either<CustomException, List<Site>>> getSites(
    String idProv,
    String idCity,
    String status,
  ) async {
    return fdpiRest.getSites(idProv, idCity, status);
  }

  Future<Either<CustomException, List<Residence>>> getResidences(
    String idProv,
    String idCity,
    String idSite,
    String status,
  ) async {
    return fdpiRest.getResidences(idProv, idCity, idSite, status);
  }

  Future<Either<CustomException, List<Coordinates>>> getCoordinatess(
    String idCluster,
    String idSite,
  ) async {
    return fdpiRest.getCoordinatess(idCluster, idSite);
  }

  Future<Either<CustomException, List<HouseType>>> getHouseTypes(
    String idSite,
    String houseCategory,
    String status,
  ) async {
    return fdpiRest.getHouseTypes(idSite, houseCategory, status);
  }
}
