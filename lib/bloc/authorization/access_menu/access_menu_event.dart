part of 'access_menu_bloc.dart';

sealed class AccessMenuEvent extends Equatable {
  const AccessMenuEvent();

  @override
  List<Object> get props => [];
}

class LoadAccessMenu extends AccessMenuEvent {
  final String entityId;
  final String applId;

  const LoadAccessMenu({this.entityId = "FDPI", this.applId = "MOBILE"});

  @override
  List<Object> get props => [entityId, applId];
}
