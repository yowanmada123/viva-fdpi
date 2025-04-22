part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthenticationState {
  final User user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

final class NotAuthenticated extends AuthenticationState {}
