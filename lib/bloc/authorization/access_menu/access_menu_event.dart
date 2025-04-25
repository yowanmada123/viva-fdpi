part of 'access_menu_bloc.dart';

sealed class AccessMenuEvent extends Equatable {
  const AccessMenuEvent();

  @override
  List<Object> get props => [];
}

class LoadAccessMenu extends AccessMenuEvent {
  final String entityId;
  final String applId;
  final String token;

  const LoadAccessMenu({
    this.entityId = "FDPI",
    this.applId = "MOBILE",
    required this.token,
  });

  @override
  List<Object> get props => [entityId, applId, token];
}
