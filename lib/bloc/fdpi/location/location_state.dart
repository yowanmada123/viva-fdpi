// bloc/location_state.dart
part of 'location_bloc.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationState extends Equatable {
  final LocationStatus status;
  final List<Province> provinces;
  final List<City> cities;
  final List<Status> statuses;
  final Province? selectedProvince;
  final City? selectedCity;
  final Status? selectedStatus;
  final String? errorMessage;
  final Exception? exception;

  const LocationState({
    this.status = LocationStatus.initial,
    this.provinces = const [],
    this.cities = const [],
    this.statuses = const [],
    this.selectedProvince,
    this.selectedCity,
    this.selectedStatus,
    this.errorMessage,
    this.exception,
  });

  LocationState copyWith({
    LocationStatus? status,
    List<Province>? provinces,
    List<City>? cities,
    List<Status>? statuses,
    Province? selectedProvince,
    City? selectedCity,
    Status? selectedStatus,
    String? errorMessage,
    Exception? exception,
  }) {
    return LocationState(
      status: status ?? this.status,
      provinces: provinces ?? this.provinces,
      cities: cities ?? this.cities,
      statuses: statuses ?? this.statuses,
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      exception: exception ?? this.exception,
    );
  }

  @override
  List<Object?> get props => [
    status,
    provinces,
    cities,
    statuses,
    selectedProvince,
    selectedCity,
    selectedStatus,
    errorMessage,
    exception,
  ];
}

class LocationProvinceLoading extends LocationState {}

class LocationProvinceLoadSuccess extends LocationState {
  final List<Province> provinces;

  const LocationProvinceLoadSuccess(this.provinces);

  @override
  List<Object?> get props => [provinces];
}

class LocationLoadFailed extends LocationState {
  final String message;
  final Exception exception;

  const LocationLoadFailed(this.message, this.exception);

  @override
  List<Object?> get props => [message, exception];
}
