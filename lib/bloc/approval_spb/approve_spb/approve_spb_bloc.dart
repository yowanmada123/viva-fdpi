import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_spb.dart';
import '../../../models/approval_spb/approve_spb_request.dart';

part 'approve_spb_event.dart';
part 'approve_spb_state.dart';

class ApproveSpbBloc extends Bloc<ApproveSpbEvent, ApproveSpbState> {
  final ApprovalSpbRepository approvalSpbRepository;
  ApproveSpbBloc({required this.approvalSpbRepository})
    : super(ApproveSpbInitial()) {
    on<ApproveSpbLoad>(_onApproveSpbLoad);
  }

  Future<void> _onApproveSpbLoad(
    ApproveSpbLoad event,
    Emitter<ApproveSpbState> emit,
  ) async {
    emit(ApproveSpbLoading());

    if (event.status == "reject") {
      final result = await approvalSpbRepository.rejectSpb(
        data: ApproveSpbRequest(idSpb: event.idSpb, typeAprv: event.typeAprv),
      );
      result.fold(
        (error) =>
            emit(ApproveSpbFailure(message: error.message!, exception: error)),
        (data) => emit(ApproveSpbSuccess(message: data)),
      );
    }

    if (event.status == "approve") {
      final result = await approvalSpbRepository.approvalSpb(
        data: ApproveSpbRequest(idSpb: event.idSpb, typeAprv: event.typeAprv),
      );
      result.fold(
        (error) =>
            emit(ApproveSpbFailure(message: error.message!, exception: error)),
        (data) => emit(ApproveSpbSuccess(message: data)),
      );
    }
  }
}
