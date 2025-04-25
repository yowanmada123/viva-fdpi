part of 'login_form_bloc.dart';

sealed class LoginFormState extends Equatable {
  const LoginFormState();

  @override
  List<Object> get props => [];
}

final class LoginFormInitial extends LoginFormState {}

final class LoginFormLoading extends LoginFormState {}

final class LoginFormSuccess extends LoginFormState {
  final User user;
  final String token;

  const LoginFormSuccess({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}

final class LoginFormError extends LoginFormState {
  final String message;

  const LoginFormError({required this.message});

  @override
  List<Object> get props => [message];
}
