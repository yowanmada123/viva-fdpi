import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';
import 'package:fdpi_app/models/checklistCleaningProgress.dart';

part 'cleaning_checklist_event.dart';
part 'cleaning_checklist_state.dart';

class CleaningChecklistBloc
    extends Bloc<CleaningChecklistEvent, CleaningChecklistState> {
  final SPKRepository spkRepository;
  CleaningChecklistBloc({required this.spkRepository})
    : super(CleaningChecklistInitial()) {
    on<LoadCleaningChecklist>(_onLoadCleaningChecklist);
  }

  Future<void> _onLoadCleaningChecklist(
    LoadCleaningChecklist event,
    Emitter<CleaningChecklistState> emit,
  ) async {
    emit(CleaningChecklistLoading());
    final result = await spkRepository.getCleaningChecklistItem(
      qcTransId: event.qcTransId,
    );

    result.fold(
      (failure) => emit(
        CleaningChecklistLoadFailure(
          message: failure.message!,
          exception: failure,
        ),
      ),
      (data) => emit(CleaningChecklistLoadSuccess(sprChecklistItem: data)),
    );
  }
}
