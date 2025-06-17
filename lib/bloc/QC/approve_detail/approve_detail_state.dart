part of 'approve_detail_bloc.dart';

sealed class ApproveDetailState extends Equatable {
  const ApproveDetailState();

  @override
  List<Object> get props => [];
}

final class ApproveDetailInitial extends ApproveDetailState {}

final class ApproveDetailLoading extends ApproveDetailState {}

final class ApproveDetailSuccess extends ApproveDetailState {
  final DetailApproveResponse detailApproveResponse;
  const ApproveDetailSuccess({required this.detailApproveResponse});
}

final class ApproveDetailError extends ApproveDetailState {
  final String message;
  final Exception exception;
  const ApproveDetailError({required this.message, required this.exception});
}
