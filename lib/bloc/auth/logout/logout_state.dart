part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {}

final class LogoutFailure extends LogoutState {
  final Exception exception;
  final String errorMessage;

  const LogoutFailure({required this.exception, required this.errorMessage});

  @override
  List<Object> get props => [exception, errorMessage];
}
