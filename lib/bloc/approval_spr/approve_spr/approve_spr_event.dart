part of 'approve_spr_bloc.dart';

sealed class ApproveSprEvent extends Equatable {
  const ApproveSprEvent();

  @override
  List<Object> get props => [];
}

class ApproveSprLoad extends ApproveSprEvent {
  final String idSpr;
  final String typeAprv;
  final String status;
  const ApproveSprLoad({
    required this.idSpr,
    required this.typeAprv,
    required this.status,
  });
}
