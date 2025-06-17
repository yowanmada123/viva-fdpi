part of 'approval_spb_detail_bloc.dart';

sealed class ApprovalSpbDetailState extends Equatable {
  const ApprovalSpbDetailState();

  @override
  List<Object> get props => [];
}

final class ApprovalSpbDetailInitial extends ApprovalSpbDetailState {}

final class ApprovalSpbDetailLoading extends ApprovalSpbDetailState {}

final class ApprovalSpbDetailFailure extends ApprovalSpbDetailState {
  final String message;
  final Exception exception;
  const ApprovalSpbDetailFailure({
    required this.message,
    required this.exception,
  });
}

final class ApprovalSpbDetailSuccess extends ApprovalSpbDetailState {
  final ApprovalSpbDetail spbDetail;
  const ApprovalSpbDetailSuccess({required this.spbDetail});
}
