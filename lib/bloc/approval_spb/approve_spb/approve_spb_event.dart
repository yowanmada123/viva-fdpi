part of 'approve_spb_bloc.dart';

sealed class ApproveSpbEvent extends Equatable {
  const ApproveSpbEvent();

  @override
  List<Object> get props => [];
}

class ApproveSpbLoad extends ApproveSpbEvent {
  final String idSpb;
  final String typeAprv;
  final String status;
  const ApproveSpbLoad({
    required this.idSpb,
    required this.typeAprv,
    required this.status,
  });
}
