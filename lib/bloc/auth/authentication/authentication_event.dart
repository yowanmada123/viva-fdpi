part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SetAuthenticationStatus extends AuthenticationEvent {
  final bool isAuthenticated;
  final User? user;

  const SetAuthenticationStatus({required this.isAuthenticated, this.user});
}
