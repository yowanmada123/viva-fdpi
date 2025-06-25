part of 'approval_po_list_bloc.dart';

sealed class ApprovalPoListState extends Equatable {
  const ApprovalPoListState();

  @override
  List<Object> get props => [];
}

final class ApprovalPoListInitial extends ApprovalPoListState {}

final class ApprovalPoListLoadingState extends ApprovalPoListState {}

final class ApprovalPoListFailureState extends ApprovalPoListState {
  final String messsage;
  final Exception exception;
  const ApprovalPoListFailureState({
    required this.messsage,
    required this.exception,
  });
}

final class ApprovalPoListSuccessState extends ApprovalPoListState {
  final List<ApprovalPo> data;
  const ApprovalPoListSuccessState(this.data);
}
