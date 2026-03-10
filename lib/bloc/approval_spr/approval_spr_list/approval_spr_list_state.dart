part of 'approval_spr_list_bloc.dart';

sealed class ApprovalSprListState extends Equatable {
  const ApprovalSprListState();

  @override
  List<Object> get props => [];
}

final class ApprovalSprListInitial extends ApprovalSprListState {}

final class ApprovalSprListLoading extends ApprovalSprListState {}

final class ApprovalSprListFailure extends ApprovalSprListState {
  final String message;
  final Exception exception;
  const ApprovalSprListFailure({
    required this.message,
    required this.exception,
  });
}

final class ApprovalSprListSuccess extends ApprovalSprListState {
  final List<Spr> sprList;
  const ApprovalSprListSuccess({required this.sprList});
}
