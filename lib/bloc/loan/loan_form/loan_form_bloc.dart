import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/loan_repository.dart';
import '../../../models/loan/vendor_spk.dart';
import '../../../models/master/loan_type.dart';
import '../../../models/master/vendor.dart';

part 'loan_form_event.dart';
part 'loan_form_state.dart';

class LoanFormBloc extends Bloc<LoanFormEvent, LoanFormState> {
  final LoanRepository loanRepository;

  LoanFormBloc({required this.loanRepository}) : super(LoanFormState()) {
    on<VendorChanged>(_onVendorChanged);
    on<SpkVendorChanged>(_onSpkVendorChanged);
    on<LoanFormSubmit>(_onLoanFormSubmit);
    on<LoanFormFirstPageChanged>(_onLoanFormFirstPageChanged);
    on<LoanFormSecondPageChanged>(_onLoanFormSecondPageChanged);
    on<FormReset>(_onFormReset);
  }

  _onVendorChanged(event, state) {
    state.emit(state.copyWith(selectedVendor: event.vendor));
  }

  _onSpkVendorChanged(event, state) {
    state.emit(state.copyWith(selectedSpk: event.vendor));
  }

  Future<void> _onLoanFormSubmit(event, state) async {
    state.emit(state.copyWith(status: FormStatus.loading));

    final result = await loanRepository.storeLoan(
      vendorId: state.selectedVendor!.id,
      spkId: state.selectedSpk!.id,
      loanTypeId: state.selectedLoanType!.id,
      dateLoan: state.dateLoan,
      amount: state.amount,
      remark: state.remark,
    );
    result.fold(
      (error) => state.emit(
        state.copyWith(status: FormStatus.failure, exception: error),
      ),
      (data) => state.emit(state.copyWith(status: FormStatus.success)),
    );
  }

  _onFormReset(event, state) {
    state.emit(
      state.copyWith(
        selectedSpk: null,
        selectedLoanType: null,
        dateLoan: null,
        amount: null,
        remark: null,
        status: FormStatus.initial,
        selectedVendor: null,
      ),
    );
  }

  _onLoanFormFirstPageChanged(event, state) {
    state.emit(state.copyWith(status: FormStatus.initial));
  }

  _onLoanFormSecondPageChanged(event, state) {
    state.emit(state.copyWith(status: FormStatus.secondPage));
  }
}
