part of 'approval_pr_list_bloc.dart';

sealed class ApprovalPrListEvent extends Equatable {
  const ApprovalPrListEvent();

  @override
  List<Object> get props => [];
}

class GetApprovalPRListEvent extends ApprovalPrListEvent {}

class RemoveListIndex extends ApprovalPrListEvent {
  final int index;

  const RemoveListIndex({required this.index});
}
