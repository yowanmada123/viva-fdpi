import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_spk.dart';

part 'approve_spk_event.dart';
part 'approve_spk_state.dart';

class ApproveSpkBloc extends Bloc<ApproveSpkEvent, ApproveSpkState> {
  final ApprovalSpkRepository approvalSpkRepository;
  ApproveSpkBloc({required this.approvalSpkRepository})
    : super(ApproveSpkInitial()) {
    on<ApproveSpkLoad>(_onApproveSpkLoad);
  }

  Future<void> _onApproveSpkLoad(
    ApproveSpkLoad event,
    Emitter<ApproveSpkState> emit,
  ) async {
    emit(ApproveSpkLoading());

    if (event.status == "reject") {
      final result = await approvalSpkRepository.rejectSpk(
        idSpk: event.idSpk,
        typeAprv: event.typeAprv,
        spkType: event.spkType,
      );
      result.fold(
        (error) =>
            emit(ApproveSpkFailure(message: error.message!, exception: error)),
        (data) => emit(ApproveSpkSuccess(message: data)),
      );
    }

    if (event.status == "approve") {
      final result = await approvalSpkRepository.approvalSpk(
        idSpk: event.idSpk,
        typeAprv: event.typeAprv,
        spkType: event.spkType,
      );
      result.fold(
        (error) =>
            emit(ApproveSpkFailure(message: error.message!, exception: error)),
        (data) => emit(ApproveSpkSuccess(message: data)),
      );
    }
  }
}
