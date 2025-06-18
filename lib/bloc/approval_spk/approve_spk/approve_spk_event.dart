part of 'approve_spk_bloc.dart';

sealed class ApproveSpkEvent extends Equatable {
  const ApproveSpkEvent();

  @override
  List<Object> get props => [];
}

class ApproveSpkLoad extends ApproveSpkEvent {
  final String idSpk;
  final String typeAprv;
  final String spkType;
  final String status;

  const ApproveSpkLoad({
    required this.idSpk,
    required this.typeAprv,
    required this.spkType,
    required this.status,
  });
}
