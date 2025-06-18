part of 'approve_spk_bloc.dart';

sealed class ApproveSpkState extends Equatable {
  const ApproveSpkState();

  @override
  List<Object> get props => [];
}

final class ApproveSpkInitial extends ApproveSpkState {}

final class ApproveSpkLoading extends ApproveSpkState {}

final class ApproveSpkFailure extends ApproveSpkState {
  final String message;
  final Exception exception;

  const ApproveSpkFailure({required this.message, required this.exception});
}

final class ApproveSpkSuccess extends ApproveSpkState {
  final String message;

  const ApproveSpkSuccess({required this.message});
}
