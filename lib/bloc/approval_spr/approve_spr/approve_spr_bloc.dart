import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fdpi_app/data/repository/approval_spr.dart';
import 'package:fdpi_app/models/approval_spr/approve_spr_request.dart';

part 'approve_spr_event.dart';
part 'approve_spr_state.dart';

class ApproveSprBloc extends Bloc<ApproveSprEvent, ApproveSprState> {
  final ApprovalSprRepository approvalSprRepository;
  ApproveSprBloc({required this.approvalSprRepository})
    : super(ApproveSprInitial()) {
    on<ApproveSprLoad>(_onApproveSprLoad);
  }

  Future<void> _onApproveSprLoad(
    ApproveSprLoad event,
    Emitter<ApproveSprState> emit,
  ) async {
    emit(ApproveSprLoading());

    if (event.status == "reject") {
      final result = await approvalSprRepository.rejectSpr(
        data: ApproveSprRequest(idSpr: event.idSpr, typeAprv: event.typeAprv),
      );
      result.fold(
        (error) =>
            emit(ApproveSprFailure(message: error.message!, exception: error)),
        (data) => emit(ApproveSprSuccess(message: data)),
      );
    }

    if (event.status == "approve") {
      final result = await approvalSprRepository.approvalSpr(
        data: ApproveSprRequest(idSpr: event.idSpr, typeAprv: event.typeAprv),
      );
      result.fold(
        (error) =>
            emit(ApproveSprFailure(message: error.message!, exception: error)),
        (data) => emit(ApproveSprSuccess(message: data)),
      );
    }
  }
}
