part of 'approval_spk_list_bloc.dart';

sealed class ApprovalSpkListState extends Equatable {
  const ApprovalSpkListState();

  @override
  List<Object> get props => [];
}

final class ApprovalSpkListInitial extends ApprovalSpkListState {}

final class ApprovalSpkListLoading extends ApprovalSpkListState {}

final class ApprovalSpkListLoadFailure extends ApprovalSpkListState {
  final String message;
  final Exception error;
  const ApprovalSpkListLoadFailure({
    required this.message,
    required this.error,
  });
}

final class ApprovalSpkListLoadSuccess extends ApprovalSpkListState {
  final List<ApprovalSpk> spkList;
  const ApprovalSpkListLoadSuccess({required this.spkList});
}
