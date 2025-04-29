part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class GetBookings extends BookingEvent {
  final String idSite;
  final String idCluster;
  final String startDate;
  final String endDate;

  const GetBookings(this.idSite, this.idCluster, this.startDate, this.endDate);

  @override
  List<Object> get props => [idSite, idCluster, startDate, endDate];
}
