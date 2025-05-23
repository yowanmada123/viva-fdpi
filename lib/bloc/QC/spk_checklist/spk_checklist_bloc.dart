import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/spk_repository.dart';
import '../../../models/checklistSpkProgress.dart';

part 'spk_checklist_event.dart';
part 'spk_checklist_state.dart';

class SpkChecklistBloc extends Bloc<SpkChecklistEvent, SpkChecklistState> {
  final SPKRepository spkRepository;
  SpkChecklistBloc({required this.spkRepository})
    : super(SpkChecklistInitial()) {
    on<LoadSpkChecklist>(_onLoadSpkChecklist);
  }

  Future<void> _onLoadSpkChecklist(
    LoadSpkChecklist event,
    Emitter<SpkChecklistState> emit,
  ) async {
    emit(SpkChecklistLoading());
    final result = await spkRepository.getSpkChecklistItem(
      qcTransId: event.qcTransId,
    );

    result.fold(
      (failure) => emit(
        SpkChecklistLoadFailure(message: failure.message!, error: failure),
      ),
      (data) => emit(SpkChecklistLoadSuccess(checklistItem: data)),
    );
  }
}
