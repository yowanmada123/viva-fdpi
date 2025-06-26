import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_po_repository.dart';

part 'approve_po_event.dart';
part 'approve_po_state.dart';

class ApprovePoBloc extends Bloc<ApprovePoEvent, ApprovePoState> {
  final ApprovalPORepository approvalPORepository;
  ApprovePoBloc({required this.approvalPORepository})
    : super(ApprovePoInitial()) {
    on<ApprovePoLoadEvent>(_onApprovePO);
  }

  Future<void> _onApprovePO(
    ApprovePoLoadEvent event,
    Emitter<ApprovePoState> emit,
  ) async {
    emit(ApprovePoLoading());

    if (event.status == "reject") {
      final result = await approvalPORepository.rejectPO(
        poId: event.poId,
        typeAprv: event.typeAprv,
      );
      result.fold(
        (error) =>
            emit(ApprovePoFailure(message: error.message!, exception: error)),
        (data) => emit(ApprovePoSuccess(message: data)),
      );
    }

    if (event.status == "approve") {
      final result = await approvalPORepository.approvalPO(
        poId: event.poId,
        typeAprv: event.typeAprv,
      );
      result.fold(
        (error) =>
            emit(ApprovePoFailure(message: error.message!, exception: error)),
        (data) => emit(ApprovePoSuccess(message: data)),
      );
    }
  }
}
