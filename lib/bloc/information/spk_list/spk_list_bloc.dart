import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';
import 'package:fdpi_app/models/fdpi/spk_review/spk.dart';

part 'spk_list_event.dart';
part 'spk_list_state.dart';

class SpkListBloc extends Bloc<SpkListEvent, SpkListState> {
  final SPKRepository spkRepository;

  SpkListBloc({required this.spkRepository}) : super(SpkListInitial()) {
    on<GetSpkList>(_getSpkList);
  }

  Future<void> _getSpkList(GetSpkList event, Emitter<SpkListState> emit) async {
    emit(SpkListLoading());
    final result = await spkRepository.getSPKList(
      idSite: event.idSite,
      idCluster: event.idCluster,
      idHouse: event.idHouse,
      spkType: event.spkType,
    );
    result.fold(
      (failure) =>
          emit(SpkListLoadFailure(message: failure.message!, error: failure)),
      (data) => emit(SpkListLoadSuccess(spkList: data)),
    );
  }
}
