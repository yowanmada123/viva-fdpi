import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/approval_po_repository.dart';

import '../../../models/approval_po/approval_po.dart';

part 'approval_po_list_event.dart';
part 'approval_po_list_state.dart';

class ApprovalPoListBloc
    extends Bloc<ApprovalPoListEvent, ApprovalPoListState> {
  final ApprovalPORepository approvalPORepository;
  ApprovalPoListBloc({required this.approvalPORepository})
    : super(ApprovalPoListInitial()) {
    on<GetApprovalPOListEvent>(_onGetPOList);
  }

  Future<void> _onGetPOList(
    GetApprovalPOListEvent event,
    Emitter<ApprovalPoListState> emit,
  ) async {
    emit(ApprovalPoListLoadingState());
    final result = await approvalPORepository.getPOList();
    result.fold(
      (error) => emit(
        ApprovalPoListFailureState(messsage: error.message!, exception: error),
      ),
      (data) => emit(ApprovalPoListSuccessState(data)),
    );
  }
}
