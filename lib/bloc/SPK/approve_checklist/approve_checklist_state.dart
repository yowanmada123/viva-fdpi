part of 'approve_checklist_bloc.dart';

sealed class ApproveChecklistState extends Equatable {
  const ApproveChecklistState();

  @override
  List<Object> get props => [];
}

final class ApproveChecklistInitial extends ApproveChecklistState {}

final class ApproveChecklistLoading extends ApproveChecklistState {}

final class ApproveChecklistLoadSuccess extends ApproveChecklistState {
  final String message;
  const ApproveChecklistLoadSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class ApproveChecklistLoadFailure extends ApproveChecklistState {
  final String message;
  final Exception error;
  const ApproveChecklistLoadFailure({
    required this.message,
    required this.error,
  });

  @override
  List<Object> get props => [message, error];
}
