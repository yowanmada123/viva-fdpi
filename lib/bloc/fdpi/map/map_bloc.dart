import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/fdpi_repository.dart';
import '../../../models/fdpi/house.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final FdpiRepository fdpiRepository;

  MapBloc({required this.fdpiRepository}) : super(MapInitial()) {
    on<LoadMap>(_onLoadMap);
  }

  Future<void> _onLoadMap(LoadMap event, Emitter<MapState> emit) async {
    emit(MapLoading());
    final result = await fdpiRepository.getCoordinatess(
      event.idCluster,
      event.idSite,
    );

    result.fold(
      (failure) => emit(
        MapLoadFailure(errorMessage: failure.message!, exception: failure),
      ),
      (units) => emit(MapLoadSuccess(units: units)),
    );
  }
}
