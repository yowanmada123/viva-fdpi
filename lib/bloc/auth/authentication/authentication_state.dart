part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthenticationState {
  final User user;
  final String token;

  const Authenticated({required this.user, required this.token});

  @override
  List<Object> get props => [user, token];
}

final class NotAuthenticated extends AuthenticationState {}
