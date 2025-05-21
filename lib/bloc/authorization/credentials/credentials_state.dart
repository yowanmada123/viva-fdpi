part of 'credentials_bloc.dart';

sealed class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

final class CredentialsInitial extends CredentialsState {}

final class CredentialsLoadFailure extends CredentialsState {
  final String errorMessage;
  final Exception exception;
  const CredentialsLoadFailure({
    required this.errorMessage,
    required this.exception,
  });
}

final class CredentialsLoadSuccess extends CredentialsState {
  final Map<String, String> credentials;
  const CredentialsLoadSuccess({required this.credentials});
}
