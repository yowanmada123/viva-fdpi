part of 'credentials_bloc.dart';

sealed class CredentialsEvent extends Equatable {
  const CredentialsEvent();

  @override
  List<Object> get props => [];
}

final class CredentialsLoad extends CredentialsEvent {
  final String entityId;
  final String applId;

  const CredentialsLoad({this.entityId = "FDPI", this.applId = "MOBILE"});

  @override
  List<Object> get props => [entityId, applId];
}
