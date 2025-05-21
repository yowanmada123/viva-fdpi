import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';

part 'approve_checklist_event.dart';
part 'approve_checklist_state.dart';

class ApproveChecklistBloc
    extends Bloc<ApproveChecklistEvent, ApproveChecklistState> {
  final SPKRepository spkRepository;

  ApproveChecklistBloc({required this.spkRepository})
    : super(ApproveChecklistInitial()) {
    on<ApproveChecklistEventInit>(_approveChecklistEventInit);
  }

  Future<void> _approveChecklistEventInit(
    ApproveChecklistEventInit event,
    Emitter<ApproveChecklistState> emit,
  ) async {
    emit(ApproveChecklistLoading());

    final result = await spkRepository.approveChecklist(
      qcTransId: event.qcTransId,
      idQcItem: event.idQcItem,
      remark: event.remark ?? "",
      imgBase64: event.imgBase64 ?? '',
      idWork: event.idWork,
    );
    result.fold(
      (failure) => emit(
        ApproveChecklistLoadFailure(message: failure.message!, error: failure),
      ),
      (data) => emit(ApproveChecklistLoadSuccess(message: data)),
    );
  }
}
