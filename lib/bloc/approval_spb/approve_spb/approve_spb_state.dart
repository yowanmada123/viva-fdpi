part of 'approve_spb_bloc.dart';

sealed class ApproveSpbState extends Equatable {
  const ApproveSpbState();

  @override
  List<Object> get props => [];
}

final class ApproveSpbInitial extends ApproveSpbState {}

final class ApproveSpbLoading extends ApproveSpbState {}

final class ApproveSpbSuccess extends ApproveSpbState {
  final String message;
  const ApproveSpbSuccess({required this.message});
}

final class ApproveSpbFailure extends ApproveSpbState {
  final String message;
  final Exception exception;
  const ApproveSpbFailure({required this.message, required this.exception});
}
