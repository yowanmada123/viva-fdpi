import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/fdpi_repository.dart';
import '../../../models/fdpi/residence.dart';

part 'residence_event.dart';
part 'residence_state.dart';

class ResidenceBloc extends Bloc<ResidenceEvent, ResidenceState> {
  final FdpiRepository fdpiRepository;

  ResidenceBloc({required this.fdpiRepository})
    : super(const ResidenceState()) {
    on<LoadResidence>(_loadResidence);
    on<ResetResidenceEvent>(_resetResidence);
  }

  void _loadResidence(LoadResidence event, Emitter<ResidenceState> emit) async {
    emit(ResidenceLoading());

    final result = await fdpiRepository.getResidences(
      event.idProvince,
      event.idCity,
      event.idSite,
      event.status,
    );

    result.fold(
      (error) => emit(
        ResidenceLoadFailure(errorMessage: error.message!, exception: error),
      ),
      (data) => emit(ResidenceLoadSuccess(residences: data)),
    );
  }

  void _resetResidence(
    ResetResidenceEvent event,
    Emitter<ResidenceState> emit,
  ) {
    emit(const ResidenceState());
  }
}
