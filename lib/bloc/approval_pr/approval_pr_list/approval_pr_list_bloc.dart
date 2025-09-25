import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_pr_repository.dart';
import '../../../models/approval_pr/approval_pr.dart';

part 'approval_pr_list_event.dart';
part 'approval_pr_list_state.dart';

class ApprovalPrListBloc
    extends Bloc<ApprovalPrListEvent, ApprovalPrListState> {
  final ApprovalPRRepository approvalPRRepository;

  ApprovalPrListBloc({required this.approvalPRRepository})
    : super(ApprovalPrListInitial()) {
    on<GetApprovalPRListEvent>(_onGetListApprovalPR);
    on<RemoveListIndex>(_onRemoveListIndex);
  }

  void _onGetListApprovalPR(
    GetApprovalPRListEvent event,
    Emitter<ApprovalPrListState> emit,
  ) async {
    emit(ApprovalPrListLoadingState());
    final result = await approvalPRRepository.getPRList();
    result.fold(
      (failure) => emit(
        ApprovalPrListFailureState(message: failure.message!, error: failure),
      ),
      (data) => emit(ApprovalPrListSuccessState(data: data)),
    );
  }

  void _onRemoveListIndex(
    RemoveListIndex event,
    Emitter<ApprovalPrListState> emit,
  ) {
    print("index ${event.index}");
    final currentState = state;
    if (currentState is ApprovalPrListSuccessState) {
      emit(ApprovalPrListLoadingState());
      final updatedList = List<ApprovalPR>.from(currentState.data)
        ..removeAt(event.index);

      emit(ApprovalPrListSuccessState(data: updatedList));
    }
  }
}
