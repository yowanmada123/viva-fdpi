import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/spk_repository.dart';
import '../../../models/checklistSprProgress.dart';

part 'spr_checklist_event.dart';
part 'spr_checklist_state.dart';

class SprChecklistBloc extends Bloc<SprChecklistEvent, SprChecklistState> {
  final SPKRepository spkRepository;
  SprChecklistBloc({required this.spkRepository})
    : super(SprChecklistInitial()) {
    on<LoadSprChecklist>(_onLoadSprChecklist);
  }

  Future<void> _onLoadSprChecklist(
    LoadSprChecklist event,
    Emitter<SprChecklistState> emit,
  ) async {
    emit(SprChecklistLoading());
    final result = await spkRepository.getSprChecklistItem(
      qcTransId: event.qcTransId,
    );

    result.fold(
      (failure) => emit(
        SprChecklistLoadFailure(message: failure.message!, exception: failure),
      ),
      (data) => emit(SprChecklistLoadSuccess(sprChecklistItem: data)),
    );
  }
}
