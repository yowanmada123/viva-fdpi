import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/data_providers/rest_api/fdpi/fdpi_rest.dart';
import '../../../models/fdpi/house_type.dart';

part 'house_type_event.dart';
part 'house_type_state.dart';

class HouseTypeBloc extends Bloc<HouseTypeEvent, HouseTypeState> {
  final FdpiRest fdpiRest;
  HouseTypeBloc({required this.fdpiRest}) : super(HouseTypeInitial()) {
    on<GetHouseTypesEvent>(_getHouseTypes);
  }

  Future<void> _getHouseTypes(
    GetHouseTypesEvent event,
    Emitter<HouseTypeState> emit,
  ) async {
    final response = await fdpiRest.getHouseTypes(
      event.idSite,
      event.houseCategory,
      event.status,
    );
    response.fold(
      (error) =>
          emit(HouseTypeLoadFailure(message: error.message!, exception: error)),
      (data) => emit(HouseTypeLoadSuccess(houseTypes: data)),
    );
  }
}
