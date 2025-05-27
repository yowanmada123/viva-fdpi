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
  final VendorSpk? vendor;
  const SpkVendorChanged(this.vendor);
}

class LoanTypeChanged extends LoanFormEvent {
  final LoanType loanType;
  const LoanTypeChanged(this.loanType);
}

class DateLoanChanged extends LoanFormEvent {
  final DateTime dateLoan;
  const DateLoanChanged(this.dateLoan);
}

class RemarkChanged extends LoanFormEvent {
  final String remark;
  const RemarkChanged(this.remark);
}

class AmountChanged extends LoanFormEvent {
  final String amount;
  const AmountChanged(this.amount);
}

class LoanFormSubmit extends LoanFormEvent {
  final String amount;
  const LoanFormSubmit({required this.amount});
}

class LoanFormFirstPageChanged extends LoanFormEvent {
  const LoanFormFirstPageChanged();
}

class LoanFormSecondPageChanged extends LoanFormEvent {
  const LoanFormSecondPageChanged();
}

class FormReset extends LoanFormEvent {}

class DateSelectionRequested extends LoanFormEvent {
  final BuildContext context;
  const DateSelectionRequested(this.context);
}
