import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../models/errors/custom_exception.dart';
import '../../../../models/loan/vendor_spk.dart';
import '../../../../models/master/vendor.dart';
import '../../../../utils/net_utils.dart';

class LoanRest {
  Dio dio;

  LoanRest(this.dio);

  Future<Either<CustomException, List<VendorSpk>>> getVendorSpk({
    required String vendorId,
    String? activeFlag,
  }) async {
    try {
      dio.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/kasbon/getKasbonSPK (POST)',
      );

      final payload = {"vendor_id": vendorId, "active_flag": activeFlag ?? ""};

      final response = await dio.post(
        "api/fpi/kasbon/getKasbonSPK",
        data: payload,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final vendorSpk = List<VendorSpk>.from(
          body['data'].map((e) {
            return VendorSpk.fromMap(e);
          }),
        );
        return Right(vendorSpk);
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

  Future<Either<CustomException, String>> storeLoan({
    required String dateLoan,
    required String loanTypeId,
    required String amount,
    required String vendorId,
    required String remark,
    required String spkId,
  }) async {
    try {
      dio.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/kasbon/storeKasbon (POST)',
      );

      final payload = {
        "tr_date": dateLoan,
        "str1": loanTypeId,
        "amount": amount,
        "vendor_id": vendorId,
        "remark": remark,
        "id_spk": spkId,
      };

      log("Request body: $payload");

      final response = await dio.post(
        "api/fpi/kasbon/storeKasbon",
        data: payload,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;

        final message = body['message'];
        return Right(message);
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

  Future<Either<CustomException, List<Vendor>>> getVendorWithSpk() async {
    try {
      dio.options.headers['requiresToken'] = true;
      log(
        'Request to https://api-fpi.kencana.org/api/fpi/kasbon/getKasbonVendor (POST)',
      );

      final response = await dio.post("api/fpi/kasbon/getKasbonVendor");

      if (response.statusCode != 200) {
        return Left(NetUtils.parseErrorResponse(response: response.data));
      }

      final data = response.data;

      final result = List<Vendor>.from(
        data['data'].map((e) => Vendor.fromMap(e)),
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(NetUtils.parseDioException(e));
    } on Exception catch (e) {
      return Future.value(Left(CustomException(message: e.toString())));
    } catch (e) {
      return Left(CustomException(message: e.toString()));
    }
  }
}
