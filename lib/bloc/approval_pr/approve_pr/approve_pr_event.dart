part of 'approve_pr_bloc.dart';

sealed class ApprovePrEvent extends Equatable {
  const ApprovePrEvent();

  @override
  List<Object> get props => [];
}

final class ApprovePrLoadEvent extends ApprovePrEvent {
  final String prId;
  final String typeAprv;
  final String status;

  const ApprovePrLoadEvent({
    required this.prId,
    required this.typeAprv,
    required this.status,
  });
}
