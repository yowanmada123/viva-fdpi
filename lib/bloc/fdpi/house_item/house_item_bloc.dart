import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/models/fdpi/house_item.dart';

import '../../../data/data_providers/rest_api/fdpi/fdpi_rest.dart';
import '../../../data/repository/fdpi_repository.dart';

part 'house_item_event.dart';
part 'house_item_state.dart';

class HouseItemBloc extends Bloc<HouseItemEvent, HouseItemState> {
  final FdpiRepository fdpiRepository;
  HouseItemBloc({required this.fdpiRepository}) : super(HouseItemInitial()) {
    on<GetHouseItem>(_getHouseItem);
  }

  Future<void> _getHouseItem(
    GetHouseItem event,
    Emitter<HouseItemState> emit,
  ) async {
    emit(HouseItemLoading());
    final response = await fdpiRepository.getHouseItem(
      event.idProvince,
      event.idProvCity,
      event.idSite,
      event.idCluster,
      event.category,
      event.status,
      event.idHouseType,
    );
    response.fold(
      (error) =>
          emit(HouseItemLoadFailure(message: error.message!, exception: error)),
      (data) => emit(HouseItemLoadSuccess(houseItems: data)),
    );
  }
}
