part of 'loan_type_bloc.dart';

sealed class LoanTypeState extends Equatable {
  const LoanTypeState();

  @override
  List<Object> get props => [];
}

final class LoanTypeInitial extends LoanTypeState {}

final class LoanTypeLoading extends LoanTypeState {}

final class LoanTypeLoadFailure extends LoanTypeState {
  final String message;
  final Exception exception;
  const LoanTypeLoadFailure({required this.message, required this.exception});
}

final class LoanTypeLoadSuccess extends LoanTypeState {
  final List<LoanType> loanTypes;
  const LoanTypeLoadSuccess({required this.loanTypes});
}
