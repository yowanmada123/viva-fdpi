import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_spb.dart';
import '../../../models/approval_spb/approval_spb_detail.dart';

part 'approval_spb_detail_event.dart';
part 'approval_spb_detail_state.dart';

class ApprovalSpbDetailBloc
    extends Bloc<ApprovalSpbDetailEvent, ApprovalSpbDetailState> {
  final ApprovalSpbRepository approvalSpbRepository;

  ApprovalSpbDetailBloc({required this.approvalSpbRepository})
    : super(ApprovalSpbDetailInitial()) {
    on<ApprovalSpbDetailLoad>(_onApprovalSpbDetailLoad);
  }

  Future<void> _onApprovalSpbDetailLoad(
    ApprovalSpbDetailLoad event,
    Emitter<ApprovalSpbDetailState> emit,
  ) async {
    emit(ApprovalSpbDetailLoading());
    final result = await approvalSpbRepository.getSpbDetail(idSpb: event.idSpb);
    result.fold(
      (error) => emit(
        ApprovalSpbDetailFailure(message: error.message!, exception: error),
      ),
      (data) => emit(ApprovalSpbDetailSuccess(spbDetail: data)),
    );
  }
}
