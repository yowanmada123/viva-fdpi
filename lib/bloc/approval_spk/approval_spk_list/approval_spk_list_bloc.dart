import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_spk.dart';
import '../../../models/approval_spk/approval_spk.dart';

part 'approval_spk_list_event.dart';
part 'approval_spk_list_state.dart';

class ApprovalSpkListBloc
    extends Bloc<ApprovalSpkListEvent, ApprovalSpkListState> {
  final ApprovalSpkRepository approvalSpkRepository;
  ApprovalSpkListBloc({required this.approvalSpkRepository})
    : super(ApprovalSpkListInitial()) {
    on<GetSpkListEvent>(_onGetSpkList);
    on<RemoveListIndex>(_onRemoveListIndex);
  }

  void _onGetSpkList(
    GetSpkListEvent event,
    Emitter<ApprovalSpkListState> emit,
  ) async {
    emit(ApprovalSpkListLoading());
    final result = await approvalSpkRepository.getSpkList(
      idSite: event.idSite,
      idCluster: event.idCluster,
      idHouse: event.idHouse,
      approvalType: event.approvalType,
      approvalStatus: event.approvalStatus,
    );
    result.fold(
      (failure) => emit(
        ApprovalSpkListLoadFailure(message: failure.message!, error: failure),
      ),
      (data) => emit(ApprovalSpkListLoadSuccess(spkList: data)),
    );
  }

  void _onRemoveListIndex(
    RemoveListIndex event,
    Emitter<ApprovalSpkListState> emit,
  ) {
    print("index ${event.index}");
    final currentState = state;
    if (currentState is ApprovalSpkListLoadSuccess) {
      emit(ApprovalSpkListLoading());
      final updatedList = List<ApprovalSpk>.from(currentState.spkList)
        ..removeAt(event.index);

      emit(ApprovalSpkListLoadSuccess(spkList: updatedList));
    }
  }
}
