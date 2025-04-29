import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/booking_repository.dart';

part 'booking_form_event.dart';
part 'booking_form_state.dart';

class BookingFormBloc extends Bloc<BookingFormEvent, BookingFormState> {
  final BookingRepository bookingRepository;
  BookingFormBloc({required this.bookingRepository})
    : super(BookingFormInitial()) {
    on<SubmitBookingForm>(_submitBookingForm);
  }

  Future<void> _submitBookingForm(
    SubmitBookingForm event,
    Emitter<BookingFormState> emit,
  ) async {
    emit(BookingFormLoading());

    final result = await bookingRepository.submitBookingForm(
      event.namaCustomer,
      event.alamatCustomer,
      event.nomorHp,
      event.telepon,
      event.houseItem,
      event.priceList,
      event.discount,
      event.payterm,
      event.bank,
      event.expDate,
      event.remark,
    );

    result.fold(
      (failure) => emit(
        BookingFormSubmitFailure(message: failure.message!, exception: failure),
      ),
      (message) => emit(BookingFormSubmitSuccess()),
    );
  }
}
