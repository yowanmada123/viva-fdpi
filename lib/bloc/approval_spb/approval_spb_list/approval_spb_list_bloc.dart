import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/approval_spb.dart';

import '../../../models/approval_spb/spb.dart';

part 'approval_spb_list_event.dart';
part 'approval_spb_list_state.dart';

class ApprovalSpbListBloc
    extends Bloc<ApprovalSpbListEvent, ApprovalSpbListState> {
  final ApprovalSpbRepository approvalSpbRepository;

  ApprovalSpbListBloc({required this.approvalSpbRepository})
    : super(ApprovalSpbListInitial()) {
    on<GetSpbListEvent>(_onGetSpbListEvent);
  }

  void _onGetSpbListEvent(
    GetSpbListEvent event,
    Emitter<ApprovalSpbListState> emit,
  ) async {
    emit(ApprovalSpbListLoading());
    final result = await approvalSpbRepository.getSpbList(
      idSite: "",
      idCluster: "",
      idHouse: "",
    );
    result.fold(
      (error) => emit(
        ApprovalSpbListFailure(message: error.message!, exception: error),
      ),
      (data) => emit(ApprovalSpbListSuccess(spbList: data)),
    );
  }
}
