part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LoadProvinces extends LocationEvent {}

class LoadStatusResidence extends LocationEvent {}

class LoadCities extends LocationEvent {
  final String provinceId;

  const LoadCities(this.provinceId);

  @override
  List<Object> get props => [provinceId];
}

class ProvinceChanged extends LocationEvent {
  final Province? province;

  const ProvinceChanged(this.province);

  @override
  List<Object> get props => [province ?? ''];
}

class CityChanged extends LocationEvent {
  final City? city;

  const CityChanged(this.city);

  @override
  List<Object> get props => [city ?? ''];
}

class StatusChanged extends LocationEvent {
  final Status? status;

  const StatusChanged(this.status);

  @override
  List<Object> get props => [status ?? ''];
}
