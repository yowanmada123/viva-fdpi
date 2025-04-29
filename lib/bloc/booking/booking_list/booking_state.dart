part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

final class BookingLoaded extends BookingState {
  final List<Booking> bookings;
  const BookingLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

final class BookingLoadFailure extends BookingState {
  final String message;
  final Exception exception;

  const BookingLoadFailure({required this.message, required this.exception});

  @override
  List<Object> get props => [message, exception];
}

final class BookingLoading extends BookingState {}
