part of 'residence_bloc.dart';

sealed class ResidenceEvent extends Equatable {
  const ResidenceEvent();

  @override
  List<Object> get props => [];
}

class LoadResidence extends ResidenceEvent {
  final String idProvince;
  final String idCity;
  final String status;

  const LoadResidence(this.idProvince, this.idCity, this.status);

  @override
  List<Object> get props => [idProvince, idCity, status];
}