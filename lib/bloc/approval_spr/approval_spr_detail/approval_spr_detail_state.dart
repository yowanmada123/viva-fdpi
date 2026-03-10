part of 'approval_spr_detail_bloc.dart';

sealed class ApprovalSprDetailState extends Equatable {
  const ApprovalSprDetailState();

  @override
  List<Object> get props => [];
}

final class ApprovalSprDetailInitial extends ApprovalSprDetailState {}

final class ApprovalSprDetailLoading extends ApprovalSprDetailState {}

final class ApprovalSprDetailFailure extends ApprovalSprDetailState {
  final String message;
  final Exception exception;
  const ApprovalSprDetailFailure({
    required this.message,
    required this.exception,
  });
}

final class ApprovalSprDetailSuccess extends ApprovalSprDetailState {
  final ApprovalSprDetail sprDetail;
  const ApprovalSprDetailSuccess({required this.sprDetail});
}
