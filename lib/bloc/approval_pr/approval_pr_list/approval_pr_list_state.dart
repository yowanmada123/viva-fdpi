part of 'approval_pr_list_bloc.dart';

sealed class ApprovalPrListState extends Equatable {
  const ApprovalPrListState();

  @override
  List<Object> get props => [];
}

final class ApprovalPrListInitial extends ApprovalPrListState {}

final class ApprovalPrListLoadingState extends ApprovalPrListState {}

final class ApprovalPrListFailureState extends ApprovalPrListState {
  final String message;
  final Exception error;
  const ApprovalPrListFailureState({
    required this.message,
    required this.error,
  });
}

final class ApprovalPrListSuccessState extends ApprovalPrListState {
  final List<ApprovalPR> data;
  const ApprovalPrListSuccessState({required this.data});
}
