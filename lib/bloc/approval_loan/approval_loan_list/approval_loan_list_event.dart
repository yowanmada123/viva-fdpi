part of 'approval_loan_list_bloc.dart';

sealed class ApprovalLoanListEvent extends Equatable {
  const ApprovalLoanListEvent();

  @override
  List<Object> get props => [];
}

class GetLoanListEvent extends ApprovalLoanListEvent {
  final String vendorId;
  final String approvalType;
  final String approvalStatus;

  const GetLoanListEvent({
    required this.vendorId,
    required this.approvalType,
    required this.approvalStatus,
  });
}
