import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/master_repository.dart';
import '../../../models/master/loan_type.dart';

part 'loan_type_event.dart';
part 'loan_type_state.dart';

class LoanTypeBloc extends Bloc<LoanTypeEvent, LoanTypeState> {
  final MasterRepository masterRepository;

  LoanTypeBloc({required this.masterRepository}) : super(LoanTypeInitial()) {
    on<GetLoanTypeEvent>(_onGetLoanType);
  }

  Future<void> _onGetLoanType(
    GetLoanTypeEvent event,
    Emitter<LoanTypeState> emit,
  ) async {
    emit(LoanTypeLoading());
    final result = await masterRepository.getLoanType();

    result.fold(
      (failure) => emit(
        LoanTypeLoadFailure(message: failure.message!, exception: failure),
      ),
      (data) => emit(LoanTypeLoadSuccess(loanTypes: data)),
    );
  }
}
