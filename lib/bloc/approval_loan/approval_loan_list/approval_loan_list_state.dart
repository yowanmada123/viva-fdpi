part of 'approval_loan_list_bloc.dart';

sealed class ApprovalLoanListState extends Equatable {
  const ApprovalLoanListState();

  @override
  List<Object> get props => [];
}

final class ApprovalLoanListInitial extends ApprovalLoanListState {}

final class ApprovalLoanListLoading extends ApprovalLoanListState {}

final class ApprovalLoanListLoadFailure extends ApprovalLoanListState {
  final String message;
  final Exception error;
  const ApprovalLoanListLoadFailure({
    required this.message,
    required this.error,
  });
}

final class ApprovalLoanListLoadSuccess extends ApprovalLoanListState {
  final List<ApprovalLoan> loanList;
  const ApprovalLoanListLoadSuccess({required this.loanList});

  ApprovalLoanListLoadSuccess copyWith({List<ApprovalLoan>? loanList}) {
    return ApprovalLoanListLoadSuccess(loanList: loanList ?? this.loanList);
  }
}
