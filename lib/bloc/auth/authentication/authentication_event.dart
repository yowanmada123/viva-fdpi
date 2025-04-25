part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SetAuthenticationStatus extends AuthenticationEvent {
  final bool isAuthenticated;
  final User? user;
  final String? token;

  const SetAuthenticationStatus({
    required this.isAuthenticated,
    this.user,
    this.token,
  });

  @override
  List<Object> get props => [isAuthenticated, user!, token!];
}
