import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/fdpi_repository.dart';
import '../../../models/fdpi/site.dart';

part 'site_event.dart';
part 'site_state.dart';

class SiteBloc extends Bloc<SiteEvent, SiteState> {
  final FdpiRepository fdpiRepository;

  SiteBloc({required this.fdpiRepository}) : super(SiteInitial()) {
    on<GetSites>(_getSites);
  }

  Future<void> _getSites(GetSites event, Emitter<SiteState> emit) async {
    emit(SiteLoading());

    final result = await fdpiRepository.getSites(
      event.idProv,
      event.idProvCity,
      event.status,
    );

    result.fold(
      (error) => emit(
        SiteLoadedFailure(errorMessage: error.message!, exception: error),
      ),
      (data) => emit(SiteLoadedSuccess(sites: data)),
    );
  }
}
