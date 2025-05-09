import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/spk_repository.dart';
import '../../../models/QC/SPR.dart';

part 'spr_list_event.dart';
part 'spr_list_state.dart';

class SprListBloc extends Bloc<SprListEvent, SprListState> {
  final SPKRepository spkRepository;

  SprListBloc({required this.spkRepository}) : super(SprListInitial()) {
    on<GetSPRList>(_getSPRList);
  }

  Future<void> _getSPRList(GetSPRList event, Emitter<SprListState> emit) async {
    print("masuk bloc");
    emit(SprListLoading());
    final result = await spkRepository.getSPRList(
      idSite: event.idSite,
      idCluster: event.idCluster,
    );
    result.fold(
      (failure) =>
          emit(SprListLoadFailure(message: failure.message!, error: failure)),
      (data) => emit(SprListLoadSuccess(sprList: data)),
    );
  }
}
