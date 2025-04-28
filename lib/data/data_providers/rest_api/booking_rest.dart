import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../models/booking.dart';
import '../../../models/errors/custom_exception.dart';
import '../../../utils/net_utils.dart';

class BookingRest {
  Dio http;

  BookingRest(this.http);

  Future<Either<CustomException, List<Booking>>> getBooking({
    String id_site = '',
    String id_cluster = '',
    String start_date = '',
    String end_date = '',
  }) async {
    try {
      http.options.headers['requiresToken'] = true;
      log(
        'Request to https://v2.kencana.org/api/fpi/booking/getListBooking (POST)',
      );

      final body = {
        "id_site": id_site,
        "id_cluster": id_cluster,
        "start_date": start_date,
        "end_date": end_date,
      };

      log("This is the body : $body");

      final response = await http.post(
        "api/fpi/booking/getListBooking",
        data: body,
      );

      if (response.statusCode == 200) {
        log('Response body: ${response.data}');
        final body = response.data;
        final bookings = List<Booking>.from(
          body['data'].map((e) {
            return Booking.fromMap(e);
          }),
        );
        return Right(bookings);
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
