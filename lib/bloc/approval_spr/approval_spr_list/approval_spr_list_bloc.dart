import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/approval_spr.dart';
import 'package:fdpi_app/models/approval_spr/spr.dart';

part 'approval_spr_list_event.dart';
part 'approval_spr_list_state.dart';

class ApprovalSprListBloc
    extends Bloc<ApprovalSprListEvent, ApprovalSprListState> {
  final ApprovalSprRepository approvalSprRepository;

  ApprovalSprListBloc({required this.approvalSprRepository})
    : super(ApprovalSprListInitial()) {
    on<GetSprListEvent>(_onGetSprListEvent);
    on<RemoveListIndex>(_onRemoveListIndex);
  }

  void _onGetSprListEvent(
    GetSprListEvent event,
    Emitter<ApprovalSprListState> emit,
  ) async {
    emit(ApprovalSprListLoading());
    final result = await approvalSprRepository.getSprList(
      idSite: "",
      idCluster: "",
      idHouse: "",
    );
    result.fold(
      (error) => emit(
        ApprovalSprListFailure(message: error.message!, exception: error),
      ),
      (data) {
        print("SPR LIST LENGTH FROM API: ${data.length}");
        if (data.isNotEmpty) {
          print("FIRST SPR: ${data.first}");
        }
        emit(ApprovalSprListSuccess(sprList: data));
      },
    );
  }

  void _onRemoveListIndex(
    RemoveListIndex event,
    Emitter<ApprovalSprListState> emit,
  ) {
    print("index ${event.index}");
    final currentState = state;
    if (currentState is ApprovalSprListSuccess) {
      emit(ApprovalSprListLoading());
      final updatedList = List<Spr>.from(currentState.sprList)
        ..removeAt(event.index);

      emit(ApprovalSprListSuccess(sprList: updatedList));
    }
  }
}
