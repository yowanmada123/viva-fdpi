part of 'approval_spb_list_bloc.dart';

sealed class ApprovalSpbListState extends Equatable {
  const ApprovalSpbListState();

  @override
  List<Object> get props => [];
}

final class ApprovalSpbListInitial extends ApprovalSpbListState {}

final class ApprovalSpbListLoading extends ApprovalSpbListState {}

final class ApprovalSpbListFailure extends ApprovalSpbListState {
  final String message;
  final Exception exception;
  const ApprovalSpbListFailure({
    required this.message,
    required this.exception,
  });
}

final class ApprovalSpbListSuccess extends ApprovalSpbListState {
  final List<Spb> spbList;
  const ApprovalSpbListSuccess({required this.spbList});
}
