import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';
import 'package:fdpi_app/models/QC/detail_approve.dart';

part 'approve_detail_event.dart';
part 'approve_detail_state.dart';

class ApproveDetailBloc extends Bloc<ApproveDetailEvent, ApproveDetailState> {
  SPKRepository spkRepository;
  ApproveDetailBloc({required this.spkRepository})
    : super(ApproveDetailInitial()) {
    on<ApproveDetailEventInit>(_onApproveDetailEventInit);
    on<LoadApproveDetail>(_onLoadApproveDetail);
  }

  void _onApproveDetailEventInit(
    ApproveDetailEventInit event,
    Emitter<ApproveDetailState> emit,
  ) {
    emit(ApproveDetailInitial());
  }

  Future<void> _onLoadApproveDetail(
    LoadApproveDetail event,
    Emitter<ApproveDetailState> emit,
  ) async {
    emit(ApproveDetailLoading());
    final DetailApproveRequest request = DetailApproveRequest(
      qcTransId: event.qcTransId,
      idQcItem: event.idQcItem,
      idWork: event.idWork,
    );
    final result = await spkRepository.getDetailApproveDetail(request);
    result.fold(
      (failure) => emit(
        ApproveDetailError(message: failure.message!, exception: failure),
      ),
      (data) => emit(ApproveDetailSuccess(detailApproveResponse: data)),
    );
  }
}
