part of 'login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();

  @override
  List<Object> get props => [];
}

final class LoginFormSubmitted extends LoginFormEvent {
  final String username;
  final String password;
  // final String shif;

  const LoginFormSubmitted({
    required this.username,
    required this.password,
    // required this.shif,
  });

  @override
  List<Object> get props => [
    username,
    password,
    // shif,
  ];
}

final class LoginFormLogout extends LoginFormEvent {}
