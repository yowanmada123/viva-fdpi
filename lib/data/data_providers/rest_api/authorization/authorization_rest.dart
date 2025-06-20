import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';

import '../../../../models/authorization/menu.dart';
import '../../../../utils/net_utils.dart';

class AuthorizationRest {
  Dio dio;

  AuthorizationRest(this.dio);

  Future<Either<CustomException, List<Menu>>> getMenus({
    entityId,
    applId,
  }) async {
    try {
      dio.options.headers['requiresToken'] = true;

      log('Request to https://v2.kencana.org/api/mobile/getMenu (POST)');
      final data = {"entity_id": entityId, "appl_id": applId};
      final response = await dio.post("api/mobile/getMenu", data: data);

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final menu = List<Menu>.from(
          body['data'].map((e) {
            return Menu.fromMap(e);
          }),
        );

        log("menu: $menu");
        return Right(menu);
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

  Future<Either<CustomException, Map<String, String>>> getConv({
    entityId,
    applId,
  }) async {
    try {
      dio.options.headers['requiresToken'] = true;

      log(
        'Request to https://v2.kencana.org/api/mobile/getEnvConf (POST)',
      );
      final data = {"entity_id": entityId, "appl_id": applId};
      final response = await dio.post("api/mobile/getEnvConf", data: data);

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;

        Map<String, String> result = {};

        for (var item in body['data']) {
          result[item['var_id']] = item['var_value'];
        }

        print("result: $result");

        return Right(result);
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
