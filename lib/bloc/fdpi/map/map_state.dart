part of 'map_bloc.dart';

enum MapStatus { initial, loading, success, failure }

class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoadSuccess extends MapState {
  final List<Coordinates> units;

  const MapLoadSuccess({required this.units});

  @override
  List<Object?> get props => [units];
}

class MapLoadFailure extends MapState {
  final String errorMessage;
  final Exception? exception;

  const MapLoadFailure({required this.errorMessage, this.exception});

  @override
  List<Object?> get props => [errorMessage, exception];
}
