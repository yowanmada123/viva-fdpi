import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    on<LoanTypeChanged>(_onLoanTypeChanged);
    on<DateLoanChanged>(_onDateLoanChanged);
    on<RemarkChanged>(_onRemarkChanged);
    on<AmountChanged>(_onAmountChanged);
    on<DateSelectionRequested>(_onDateSelectionRequested);
    on<InitForm>(_onInitForm);
    on<FormChangeStatus>(_onFormChangeStatus);
  }

  void _onDateSelectionRequested(
    DateSelectionRequested event,
    Emitter<LoanFormState> emit,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final String formattedDateLoan = DateFormat(
        'dd MMM yyyy',
      ).format(pickedDate);

      emit(
        state.copyWith(
          dateLoan: pickedDate,
          dateLoanFormatted: formattedDateLoan,
        ),
      );
    }
  }

  void _onVendorChanged(VendorChanged event, Emitter<LoanFormState> emit) {
    emit(state.copyWith(selectedVendor: event.vendor));
  }

  void _onSpkVendorChanged(
    SpkVendorChanged event,
    Emitter<LoanFormState> emit,
  ) {
    if (event.vendor == null) {
      emit(state.unSelectSpk());
    }
    emit(state.copyWith(selectedSpk: event.vendor));
  }

  void _onRemarkChanged(RemarkChanged event, Emitter<LoanFormState> emit) {
    emit(state.copyWith(remark: event.remark));
  }

  void _onAmountChanged(AmountChanged event, Emitter<LoanFormState> emit) {
    emit(state.copyWith(amount: event.amount));
  }

  void _onLoanTypeChanged(LoanTypeChanged event, Emitter<LoanFormState> emit) {
    emit(state.copyWith(selectedLoanType: event.loanType));
  }

  void _onDateLoanChanged(DateLoanChanged event, Emitter<LoanFormState> emit) {
    final String formattedDateLoan = DateFormat(
      'dd MMM yyyy',
    ).format(event.dateLoan);

    emit(
      state.copyWith(
        dateLoan: event.dateLoan,
        dateLoanFormatted: formattedDateLoan,
      ),
    );
  }

  Future<void> _onLoanFormSubmit(
    LoanFormSubmit event,
    Emitter<LoanFormState> emit,
  ) async {
    // Validasi field yang wajib diisi
    if (state.selectedVendor == null) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          exception: Exception('Vendor harus dipilih'),
        ),
      );
      return;
    }

    if (state.dateLoan == null) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          exception: Exception('Tanggal pinjaman harus diisi'),
        ),
      );
      return;
    }

    if (event.amount.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          exception: Exception('Jumlah pinjaman harus diisi'),
        ),
      );
      return;
    }

    if (state.remark == null || state.remark!.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          exception: Exception('Remark harus diisi'),
        ),
      );
      return;
    }

    if (state.selectedSpk == null) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          exception: Exception('SPK harus dipilih'),
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormStatus.loading));

    final result = await loanRepository.storeLoan(
      vendorId: state.selectedVendor!.vendorId,
      loanTypeId:
          state.selectedLoanType == null ? 'M' : state.selectedLoanType!.str1,
      dateLoan: DateFormat('yyyy-MM-dd').format(state.dateLoan!),
      amount: event.amount.replaceAll(',', ''),
      remark: state.remark!,
      spkId: state.selectedSpk!.idSpk,
    );

    result.fold(
      (error) =>
          emit(state.copyWith(status: FormStatus.failure, exception: error)),
      (data) => emit(state.copyWith(status: FormStatus.success)),
    );
  }

  void _onFormReset(FormReset event, Emitter<LoanFormState> emit) {
    emit(state.resetState());
  }

  void _onLoanFormFirstPageChanged(
    LoanFormFirstPageChanged event,
    Emitter<LoanFormState> emit,
  ) {
    emit(state.copyWith(status: FormStatus.initial));
  }

  void _onLoanFormSecondPageChanged(
    LoanFormSecondPageChanged event,
    Emitter<LoanFormState> emit,
  ) {
    emit(state.copyWith(status: FormStatus.secondPage));
  }

  void _onInitForm(InitForm event, Emitter<LoanFormState> emit) {
    emit(
      state.copyWith(
        dateLoan: DateTime.now(),
        dateLoanFormatted: DateFormat('dd MMM yyyy').format(DateTime.now()),
      ),
    );
  }

  void _onFormChangeStatus(
    FormChangeStatus event,
    Emitter<LoanFormState> emit,
  ) {
    emit(state.copyWith(status: FormStatus.initial));
  }
}
