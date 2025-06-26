import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/approval_pr_repository.dart';

part 'approve_pr_event.dart';
part 'approve_pr_state.dart';

class ApprovePrBloc extends Bloc<ApprovePrEvent, ApprovePrState> {
  final ApprovalPRRepository approvalPRRepository;

  ApprovePrBloc({required this.approvalPRRepository})
    : super(ApprovePrInitial()) {
    on<ApprovePrLoadEvent>(_onApprovePrEvent);
  }

  void _onApprovePrEvent(
    ApprovePrLoadEvent event,
    Emitter<ApprovePrState> emit,
  ) async {
    emit(ApprovePrLoading());

    if (event.status == "reject") {
      final result = await approvalPRRepository.rejectPR(
        prId: event.prId,
        typeAprv: event.typeAprv,
      );
      result.fold(
        (error) =>
            emit(ApprovePrFailure(message: error.message!, exception: error)),
        (data) => emit(ApprovePrSuccess(message: data)),
      );
    }

    if (event.status == "approve") {
      final result = await approvalPRRepository.approvalPR(
        prId: event.prId,
        typeAprv: event.typeAprv,
      );
      result.fold(
        (error) =>
            emit(ApprovePrFailure(message: error.message!, exception: error)),
        (data) => emit(ApprovePrSuccess(message: data)),
      );
    }
  }
}
