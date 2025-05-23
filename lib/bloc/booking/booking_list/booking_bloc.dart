import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/booking_repository.dart';
import '../../../models/booking.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) : super(BookingInitial()) {
    on<GetBookings>(loadBookings);
  }

  Future<void> loadBookings(
    GetBookings event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());

    final result = await bookingRepository.getBooking(
      id_site: event.idSite,
      id_cluster: event.idCluster,
      start_date: event.startDate,
      end_date: event.endDate,
    );

    result.fold(
      (failure) => emit(
        BookingLoadFailure(message: failure.message!, exception: failure),
      ),
      (bookings) => emit(BookingLoaded(bookings: bookings)),
    );
  }
}
