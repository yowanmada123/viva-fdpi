import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';

import '../../../models/checklistItem.dart';

part 'checklist_event.dart';
part 'checklist_state.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  final SPKRepository spkRepository;
  ChecklistBloc({required this.spkRepository}) : super(ChecklistInitial()) {
    on<LoadChecklist>(_loadChecklist);
  }

  Future<void> _loadChecklist(
    LoadChecklist event,
    Emitter<ChecklistState> emit,
  ) async {
    emit(ChecklistLoading());
    final result = await spkRepository.getChecklistItem(
      idHouse: event.idHouse,
      clType: event.clType,
    );
    result.fold(
      (failure) =>
          emit(ChecklistLoadFailure(message: failure.message!, error: failure)),
      (data) => emit(ChecklistLoadSuccess(checklistItem: data)),
    );
  }
}
