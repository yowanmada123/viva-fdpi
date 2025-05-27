part of 'loan_type_bloc.dart';

sealed class LoanTypeEvent extends Equatable {
  const LoanTypeEvent();

  @override
  List<Object> get props => [];
}

class GetLoanTypeEvent extends LoanTypeEvent {}
