import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/fdpi/house_item.dart';

import '../../../../models/errors/custom_exception.dart';
import '../../../../models/fdpi/city.dart';
import '../../../../models/fdpi/house.dart';
import '../../../../models/fdpi/house_type.dart';
import '../../../../models/fdpi/province.dart';
import '../../../../models/fdpi/residence.dart';
import '../../../../models/fdpi/site.dart';
import '../../../../utils/net_utils.dart';

class FdpiRest {
  Dio http;

  FdpiRest(this.http);

  Future<Either<CustomException, List<Province>>> getProvinces() async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/master/getProvince (POST)',
      );
      final response = await http.post("api/fpi/master/getProvince");
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final province = List<Province>.from(
          body['data'].map((e) {
            return Province.fromMap(e);
          }),
        );
        return Right(province);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<City>>> getCities(String id) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://v2.kencana.org/api/fpi/master/getCity (POST)');
      final body = {"id_province": id};
      final response = await http.post("api/fpi/master/getCity", data: body);
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final cities = List<City>.from(
          body['data'].map((e) {
            return City.fromMap(e);
          }),
        );
        return Right(cities);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<Site>>> getSites(
    String? idProv,
    String? idCity,
    String? status,
  ) async {
    try {
      http.options.headers['requiresToken'] = true;
      log('Request to https://v2.kencana.org/api/fpi/site/getSite (POST)');
      final body = {
        "id_site": "",
        "category": "",
        "id_province": idProv ?? "",
        "id_prov_city": idCity ?? "",
        "status": status ?? "Aktif",
      };
      final response = await http.post("api/fpi/site/getSite", data: body);
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final sites = List<Site>.from(
          body['data'].map((e) {
            return Site.fromMap(e);
          }),
        );
        return Right(sites);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<Residence>>> getResidences(
    String? idProv,
    String? idCity,
    String? idSite,
    String? status,
  ) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/cluster/getCluster (POST)',
      );
      final body = {
        "id_site": idSite ?? "",
        "category": "",
        "id_province": idProv ?? "",
        "id_prov_city": idCity ?? "",
        "status": status ?? "Aktif",
      };
      final response = await http.post(
        "api/fpi/cluster/getCluster",
        data: body,
      );
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final residence = List<Residence>.from(
          body['data'].map((e) {
            return Residence.fromMap(e);
          }),
        );
        return Right(residence);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<Coordinates>>> getCoordinatess(
    String? idCluster,
    String? idSite,
  ) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/houseUnit/getKoordinat (POST)',
      );
      final body = {"id_cluster": idCluster, "id_site": idSite};
      final response = await http.post(
        "api/fpi/houseUnit/getKoordinat",
        data: body,
      );
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final houses = List<Coordinates>.from(
          body['data'].map((e) {
            return Coordinates.fromMap(e);
          }),
        );
        return Right(houses);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<HouseType>>> getHouseTypes(
    String? idSite,
    String? houseCategory,
    String? status,
  ) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/houseType/getHouseType (POST)',
      );
      final body = {
        "id_site": idSite,
        "houses_category": houseCategory,
        "status": status,
      };
      final response = await http.post(
        "api/fpi/houseType/getHouseType",
        data: body,
      );
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final houseTypes = List<HouseType>.from(
          body['data'].map((e) {
            return HouseType.fromMap(e);
          }),
        );
        return Right(houseTypes);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }

  Future<Either<CustomException, List<HouseItem>>> getHouseItem(
    String? idProvince,
    String? idProvCity,
    String? idSite,
    String? idCluster,
    String? category,
    String? status,
    String? idHouseType,
  ) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/houseUnit/getHouseUnit (POST)',
      );
      final body = {
        "id_province": idProvince ?? "",
        "id_prov_city": idProvCity ?? "",
        "id_site": idSite ?? "",
        "id_cluster": idCluster ?? "",
        "category": category ?? "",
        "status": status ?? "",
        "id_house_type": idHouseType ?? "",
      };
      final response = await http.post(
        "api/fpi/houseUnit/getHouseUnit",
        data: body,
      );
      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final houseItems = List<HouseItem>.from(
          body['data'].map((e) {
            return HouseItem.fromMap(e);
          }),
        );
        return Right(houseItems);
      } else {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
