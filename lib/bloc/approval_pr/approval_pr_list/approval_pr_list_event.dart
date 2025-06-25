part of 'approval_pr_list_bloc.dart';

sealed class ApprovalPrListEvent extends Equatable {
  const ApprovalPrListEvent();

  @override
  List<Object> get props => [];
}

class GetApprovalPRListEvent extends ApprovalPrListEvent {}
