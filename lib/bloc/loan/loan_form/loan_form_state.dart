part of 'loan_form_bloc.dart';

class LoanFormState extends Equatable {
  final Vendor? selectedVendor;
  final LoanType? selectedLoanType;
  final String? dateLoanFormatted;
  final DateTime? dateLoan;
  final String? amount;
  final String? remark;
  final VendorSpk? selectedSpk;
  final FormStatus status;
  final Exception? exception;

  const LoanFormState({
    this.selectedVendor,
    this.selectedLoanType,
    this.dateLoan,
    this.dateLoanFormatted,
    this.amount,
    this.remark,
    this.selectedSpk,
    this.exception,
    this.status = FormStatus.initial,
  });

  LoanFormState copyWith({
    Vendor? selectedVendor,
    LoanType? selectedLoanType,
    String? dateLoanFormatted,
    DateTime? dateLoan,
    String? amount,
    String? remark,
    VendorSpk? selectedSpk,
    Exception? exception,
    FormStatus? status,
  }) {
    return LoanFormState(
      selectedVendor: selectedVendor ?? this.selectedVendor,
      selectedLoanType: selectedLoanType ?? this.selectedLoanType,
      dateLoan: dateLoan ?? this.dateLoan,
      amount: amount ?? this.amount,
      dateLoanFormatted: dateLoanFormatted ?? this.dateLoanFormatted,
      remark: remark ?? this.remark,
      selectedSpk: selectedSpk ?? this.selectedSpk,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }

  LoanFormState resetState() {
    return LoanFormState(
      selectedVendor: null,
      selectedLoanType: null,
      dateLoan: null,
      amount: null,
      dateLoanFormatted: null,
      remark: null,
      selectedSpk: null,
      status: FormStatus.initial,
      exception: null,
    );
  }

  LoanFormState unSelectSpk() {
    return LoanFormState(
      selectedVendor: selectedVendor,
      selectedLoanType: selectedLoanType,
      dateLoan: dateLoan,
      amount: amount,
      dateLoanFormatted: dateLoanFormatted,
      remark: remark,
      selectedSpk: null,
      status: status,
      exception: exception,
    );
  }

  @override
  List<Object?> get props => [
    selectedVendor,
    selectedLoanType,
    dateLoan,
    dateLoanFormatted,
    amount,
    remark,
    selectedSpk,
    status,
    exception,
  ];
}

enum FormStatus {
  initial,
  loading,
  success,
  failure,
  submitted,
  firstPage,
  secondPage,
}
