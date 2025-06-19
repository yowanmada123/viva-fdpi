import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_loan_repository.dart';

part 'approve_loan_event.dart';
part 'approve_loan_state.dart';

class ApproveLoanBloc extends Bloc<ApproveLoanEvent, ApproveLoanState> {
  final ApprovalLoanRepository approvalLoanRepository;
  ApproveLoanBloc({required this.approvalLoanRepository})
    : super(ApproveLoanInitial()) {
    on<ApproveLoanLoad>(_onApproveLoanLoad);
  }

  Future<void> _onApproveLoanLoad(
    ApproveLoanLoad event,
    Emitter<ApproveLoanState> emit,
  ) async {
    emit(ApproveLoanLoading());

    if (event.status == "reject") {
      final result = await approvalLoanRepository.rejectLoan(
        trId: event.trId, typeAprv: event.typeAprv,
      );
      result.fold(
        (error) =>
            emit(ApproveLoanFailure(message: error.message!, error: error)),
        (data) => emit(ApproveLoanSuccess(message: data)),
      );
    }

    if (event.status == "approve") {
      final result = await approvalLoanRepository.approvalLoan(
        trId: event.trId, 
        typeAprv: event.typeAprv,
      );
      result.fold(
        (error) =>
            emit(ApproveLoanFailure(message: error.message!, error: error)),
        (data) => emit(ApproveLoanSuccess(message: data)),
      );
    }
  }
}
