import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';

import 'package:fdpi_app/models/QC/Cleaning.dart';

part 'cleaning_list_event.dart';
part 'cleaning_list_state.dart';

class CleaningListBloc extends Bloc<CleaningListEvent, CleaningListState> {
  final SPKRepository cleaningRepository;

  CleaningListBloc({required this.cleaningRepository})
    : super(CleaningListInitial()) {
    on<GetCleaningList>(_getCleaningList);
  }

  Future<void> _getCleaningList(
    GetCleaningList event,
    Emitter<CleaningListState> emit,
  ) async {
    emit(CleaningListLoading());
    final result = await cleaningRepository.getCleaningList(
      idSite: event.idSite,
      idCluster: event.idCluster,
      idHouse: event.idHouse,
    );
    result.fold(
      (failure) => emit(
        CleaningListLoadFailure(message: failure.message!, error: failure),
      ),
      (data) => emit(CleaningListLoadSuccess(cleaningList: data)),
    );
  }
}
