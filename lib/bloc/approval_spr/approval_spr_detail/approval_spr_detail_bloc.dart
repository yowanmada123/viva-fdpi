import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/approval_spr.dart';
import 'package:fdpi_app/models/approval_spr/approval_spr_detail.dart';

part 'approval_spr_detail_event.dart';
part 'approval_spr_detail_state.dart';

class ApprovalSprDetailBloc
    extends Bloc<ApprovalSprDetailEvent, ApprovalSprDetailState> {
  final ApprovalSprRepository approvalSprRepository;

  ApprovalSprDetailBloc({required this.approvalSprRepository})
    : super(ApprovalSprDetailInitial()) {
    on<ApprovalSprDetailLoad>(_onApprovalSprDetailLoad);
  }

  Future<void> _onApprovalSprDetailLoad(
    ApprovalSprDetailLoad event,
    Emitter<ApprovalSprDetailState> emit,
  ) async {
    emit(ApprovalSprDetailLoading());
    final result = await approvalSprRepository.getSprDetail(idSpr: event.idSpr);
    result.fold(
      (error) => emit(
        ApprovalSprDetailFailure(message: error.message!, exception: error),
      ),
      (data) => emit(ApprovalSprDetailSuccess(sprDetail: data)),
    );
  }
}
