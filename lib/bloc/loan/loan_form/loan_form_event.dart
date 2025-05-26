part of 'loan_form_bloc.dart';

sealed class LoanFormEvent extends Equatable {
  const LoanFormEvent();

  @override
  List<Object> get props => [];
}

class VendorChanged extends LoanFormEvent {
  final Vendor vendor;
  const VendorChanged(this.vendor);
}

class SpkVendorChanged extends LoanFormEvent {
  final VendorSpk vendor;
  const SpkVendorChanged(this.vendor);
}

class LoanFormSubmit extends LoanFormEvent {
  final String dateLoan;
  final String amount;
  final String remark;
  final LoanType loanType;

  const LoanFormSubmit({
    required this.dateLoan,
    required this.amount,
    required this.remark,
    required this.loanType,
  });
}

class LoanFormFirstPageChanged extends LoanFormEvent {
  const LoanFormFirstPageChanged();
}

class LoanFormSecondPageChanged extends LoanFormEvent {
  const LoanFormSecondPageChanged();
}

class FormReset extends LoanFormEvent {}
