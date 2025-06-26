part of 'approve_po_bloc.dart';

sealed class ApprovePoState extends Equatable {
  const ApprovePoState();

  @override
  List<Object> get props => [];
}

final class ApprovePoInitial extends ApprovePoState {}

final class ApprovePoLoading extends ApprovePoState {}

final class ApprovePoFailure extends ApprovePoState {
  final String message;
  final Exception exception;
  const ApprovePoFailure({required this.message, required this.exception});
}

final class ApprovePoSuccess extends ApprovePoState {
  final String message;
  const ApprovePoSuccess({required this.message});
}
