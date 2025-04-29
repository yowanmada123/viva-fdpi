part of 'booking_form_bloc.dart';

sealed class BookingFormState extends Equatable {
  const BookingFormState();

  @override
  List<Object> get props => [];
}

final class BookingFormInitial extends BookingFormState {}

final class BookingFormLoading extends BookingFormState {}

final class BookingFormSubmitSuccess extends BookingFormState {}

final class BookingFormSubmitFailure extends BookingFormState {
  final String message;
  final Exception exception;

  const BookingFormSubmitFailure({
    required this.message,
    required this.exception,
  });

  @override
  List<Object> get props => [message, exception];
}
