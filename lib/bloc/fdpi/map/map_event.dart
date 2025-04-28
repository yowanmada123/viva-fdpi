part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class LoadMap extends MapEvent {
  final String idCluster;
  final String idSite;

  const LoadMap(this.idCluster, this.idSite);

  @override
  List<Object> get props => [idCluster, idSite];
}
