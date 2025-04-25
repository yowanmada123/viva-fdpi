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

  const LoginFormSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class LoginFormError extends LoginFormState {
  final String message;

  const LoginFormError({required this.message});

  @override
  List<Object> get props => [message];
}
