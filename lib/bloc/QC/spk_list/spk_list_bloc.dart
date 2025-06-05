import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';

import '../../../models/QC/SPK.dart';

part 'spk_list_event.dart';
part 'spk_list_state.dart';

class SpkListBloc extends Bloc<SpkListEvent, SpkListState> {
  final SPKRepository spkRepository;
  SpkListBloc({required this.spkRepository}) : super(SpkListInitial()) {
    on<GetSPKList>(_getSPKList);
  }

  Future<void> _getSPKList(GetSPKList event, Emitter<SpkListState> emit) async {
    emit(SpkListLoading());
    final result = await spkRepository.getSPKList(
      idVendor: event.idVendor,
      idSite: event.idSite,
      idCluster: event.idCluster,
      idHouse: event.idHouse,
    );
    result.fold(
      (failure) =>
          emit(SpkListLoadFailure(message: failure.message!, error: failure)),
      (data) => emit(SpkListLoadSuccess(spkList: data)),
    );
  }
}
