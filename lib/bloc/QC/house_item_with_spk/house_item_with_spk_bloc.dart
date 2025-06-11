import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/spk_repository.dart';
import '../../../models/fdpi/house_item_spk.dart';

part 'house_item_with_spk_event.dart';
part 'house_item_with_spk_state.dart';

class HouseItemWithSpkBloc
    extends Bloc<HouseItemWithSpkEvent, HouseItemWithSpkState> {
  final SPKRepository spkRepository;
  HouseItemWithSpkBloc({required this.spkRepository})
    : super(HouseItemWithSpkInitial()) {
    on<GetHouseItemWithSpkEvent>(_onGetHouseItemWithSpkEvent);
    on<ResetHouseItemWithSpkEvent>(_onResetHouseItemWithSpkEvent);
  }

  Future<void> _onGetHouseItemWithSpkEvent(
    GetHouseItemWithSpkEvent event,
    Emitter<HouseItemWithSpkState> emit,
  ) async {
    emit(HouseItemWithSpkLoading());
    final result = await spkRepository.getHouseWithSpk(
      idSite: event.idSite,
      idCluster: event.idCluster,
      docType: event.docType,
      activeFlag: event.activeFlag ?? "Y",
    );
    result.fold(
      (error) => emit(
        HouseItemWithSpkFailure(message: error.message!, exception: error),
      ),
      (data) => emit(HouseItemWithSpkLoaded(items: data)),
    );
  }

  Future<void> _onResetHouseItemWithSpkEvent(
    ResetHouseItemWithSpkEvent event,
    Emitter<HouseItemWithSpkState> emit,
  ) async {
    emit(HouseItemWithSpkInitial());
  }
}
