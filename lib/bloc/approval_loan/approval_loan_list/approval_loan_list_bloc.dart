import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/approval_loan_repository.dart';
import 'package:fdpi_app/models/approval_loan/approval_loan.dart';

part 'approval_loan_list_event.dart';
part 'approval_loan_list_state.dart';

class ApprovalLoanListBloc
    extends Bloc<ApprovalLoanListEvent, ApprovalLoanListState> {
  final ApprovalLoanRepository approvalLoanRepository;
  ApprovalLoanListBloc({required this.approvalLoanRepository})
    : super(ApprovalLoanListInitial()) {
    on<GetLoanListEvent>(_onGetLoanList);
    on<RemoveLoanListIndex>(_onRemoveLoanListIndex);
  }

  void _onGetLoanList(
    GetLoanListEvent event,
    Emitter<ApprovalLoanListState> emit,
  ) async {
    emit(ApprovalLoanListLoading());
    final result = await approvalLoanRepository.getLoanList(
      vendorId: event.vendorId,
      approvalType: event.approvalType,
      approvalStatus: event.approvalStatus,
    );
    result.fold(
      (failure) => emit(
        ApprovalLoanListLoadFailure(message: failure.message!, error: failure),
      ),
      (data) => emit(ApprovalLoanListLoadSuccess(loanList: data)),
    );
  }

  void _onRemoveLoanListIndex(
    RemoveLoanListIndex event,
    Emitter<ApprovalLoanListState> emit,
  ) {
    print("index ${event.index}");
    final currentState = state;
    if (currentState is ApprovalLoanListLoadSuccess) {
      emit(ApprovalLoanListLoading());
      final updatedList = List<ApprovalLoan>.from(currentState.loanList)
        ..removeAt(event.index);

      emit(ApprovalLoanListLoadSuccess(loanList: updatedList));
    }
  }
}
