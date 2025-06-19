part of 'approve_loan_bloc.dart';

sealed class ApproveLoanState extends Equatable {
  const ApproveLoanState();

  @override
  List<Object> get props => [];
}

final class ApproveLoanInitial extends ApproveLoanState {}

final class ApproveLoanLoading extends ApproveLoanState {}

final class ApproveLoanSuccess extends ApproveLoanState {
  final String message;
  const ApproveLoanSuccess({required this.message});
}

final class ApproveLoanFailure extends ApproveLoanState {
  final String message;
  final Exception error;
  const ApproveLoanFailure({required this.message, required this.error});
}
