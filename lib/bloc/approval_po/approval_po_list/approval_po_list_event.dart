part of 'approval_po_list_bloc.dart';

sealed class ApprovalPoListEvent extends Equatable {
  const ApprovalPoListEvent();

  @override
  List<Object> get props => [];
}

class GetApprovalPOListEvent extends ApprovalPoListEvent {}

class RemoveListIndex extends ApprovalPoListEvent {
  final int index;

  const RemoveListIndex({required this.index});
}
