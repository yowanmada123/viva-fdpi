part of 'loan_form_bloc.dart';

class LoanFormState extends Equatable {
  final Vendor? selectedVendor;
  final LoanType? selectedLoanType;
  final String? dateLoan;
  final String? amount;
  final String? remark;
  final VendorSpk? selectedSpk;
  final FormStatus status;

  const LoanFormState({
    this.selectedVendor,
    this.selectedLoanType,
    this.dateLoan,
    this.amount,
    this.remark,
    this.selectedSpk,
    this.status = FormStatus.initial,
  });

  LoanFormState copyWith({
    Vendor? selectedVendor,
    LoanType? selectedLoanType,
    String? dateLoan,
    String? amount,
    String? remark,
    VendorSpk? selectedSpk,
    FormStatus? status,
  }) {
    return LoanFormState(
      selectedVendor: selectedVendor ?? this.selectedVendor,
      selectedLoanType: selectedLoanType ?? this.selectedLoanType,
      dateLoan: dateLoan ?? this.dateLoan,
      amount: amount ?? this.amount,
      remark: remark ?? this.remark,
      selectedSpk: selectedSpk ?? this.selectedSpk,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    selectedVendor,
    selectedLoanType,
    dateLoan,
    amount,
    remark,
    selectedSpk,
    status,
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
