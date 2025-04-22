import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/fdpi_repository.dart';
import '../../../models/fdpi/city.dart';
import '../../../models/fdpi/province.dart';
import '../../../models/fdpi/status.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final FdpiRepository fdpiRepository;

  LocationBloc({required this.fdpiRepository}) : super(const LocationState()) {
    on<LoadStatusResidence>(_onLoadStatuses);
    on<LoadProvinces>(_onLoadProvinces);
    on<LoadCities>(_onLoadCities);
    on<ProvinceChanged>(_onProvinceChanged);
    on<CityChanged>(_onCityChanged);
    on<StatusChanged>(_onStatusChanged);
  }

  Future<void> _onLoadStatuses(
    LoadStatusResidence event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(statuses: Status.statusList));
  }

  Future<void> _onLoadProvinces(
    LoadProvinces event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));
    final result = await fdpiRepository.getProvinces();

    result.fold(
      (error) => emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: error.message,
          exception: error,
        ),
      ),
      (data) =>
          emit(state.copyWith(status: LocationStatus.success, provinces: data)),
    );
  }

  Future<void> _onLoadCities(
    LoadCities event,
    Emitter<LocationState> emit,
  ) async {
    if (event.provinceId.isEmpty) return;

    final result = await fdpiRepository.getCities(event.provinceId);

    result.fold(
      (error) => emit(
        state.copyWith(
          status: LocationStatus.failure,
          errorMessage: error.message,
          exception: error,
        ),
      ),
      (data) =>
          emit(state.copyWith(status: LocationStatus.success, cities: data)),
    );
  }

  void _onProvinceChanged(ProvinceChanged event, Emitter<LocationState> emit) {
    emit(
      state.copyWith(
        selectedProvince: event.province,
        selectedCity: null, // Reset city when province changes
      ),
    );

    if (event.province != null) {
      add(LoadCities(event.province!.idProvince));
    }
  }

  void _onCityChanged(CityChanged event, Emitter<LocationState> emit) {
    emit(state.copyWith(selectedCity: event.city));
  }

  void _onStatusChanged(StatusChanged event, Emitter<LocationState> emit) {
    emit(state.copyWith(selectedStatus: event.status));
  }
}
