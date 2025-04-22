part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LoadMap extends MapEvent {
  final String idCluster;

  const LoadMap(this.idCluster);

  @override
  List<Object> get props => [idCluster];
}
