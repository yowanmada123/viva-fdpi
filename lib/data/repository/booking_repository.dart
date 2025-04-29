import 'package:dartz/dartz.dart';

import '../../models/booking.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/booking_rest.dart';

class BookingRepository {
  final BookingRest bookingRest;

  BookingRepository({required this.bookingRest});

  Future<Either<CustomException, List<Booking>>> getBooking({
    String id_site = "",
    String id_cluster = "",
    String start_date = "",
    String end_date = "",
  }) async {
    return bookingRest.getBooking(
      id_site: id_site,
      id_cluster: id_cluster,
      start_date: start_date,
      end_date: end_date,
    );
  }

  Future<Either<CustomException, String>> submitBookingForm(
    String? namaCustomer,
    String? alamatCustomer,
    String? nomorHp,
    String? telepon,
    String? houseItem,
    String? priceList,
    String? discount,
    String? payterm,
    String? bank,
    String? expDate,
    String? remark,
  ) async {
    return bookingRest.submitBookingForm(
      namaCustomer ?? '',
      alamatCustomer ?? '',
      nomorHp ?? '',
      telepon ?? '',
      houseItem ?? '',
      priceList ?? '',
      discount ?? '',
      payterm ?? '',
      bank ?? '',
      expDate ?? '',
      remark ?? '',
    );
  }
}
