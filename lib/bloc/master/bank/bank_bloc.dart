import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/master_repository.dart';
import '../../../models/bank.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final MasterRepository masterRest;

  BankBloc({required this.masterRest}) : super(BankInitial()) {
    on<GetBank>(_getBank);
  }

  Future<void> _getBank(GetBank event, Emitter<BankState> emit) async {
    emit(BankLoading());
    final result = await masterRest.getBank();

    result.fold(
      (failure) =>
          emit(BankLoadFailure(message: failure.message!, exception: failure)),
      (data) => emit(BankLoadSuccess(banks: data)),
    );
  }
}
