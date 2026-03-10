part of 'approve_spr_bloc.dart';

sealed class ApproveSprState extends Equatable {
  const ApproveSprState();

  @override
  List<Object> get props => [];
}

final class ApproveSprInitial extends ApproveSprState {}

final class ApproveSprLoading extends ApproveSprState {}

final class ApproveSprSuccess extends ApproveSprState {
  final String message;
  const ApproveSprSuccess({required this.message});
}

final class ApproveSprFailure extends ApproveSprState {
  final String message;
  final Exception exception;
  const ApproveSprFailure({required this.message, required this.exception});
}
