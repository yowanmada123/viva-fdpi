part of 'approve_loan_bloc.dart';

sealed class ApproveLoanEvent extends Equatable {
  const ApproveLoanEvent();

  @override
  List<Object> get props => [];
}

class ApproveLoanLoad extends ApproveLoanEvent {
  final String trId;
  final String typeAprv;
  final String status;
  const ApproveLoanLoad({
    required this.trId,
    required this.typeAprv,
    required this.status,
  });
}
