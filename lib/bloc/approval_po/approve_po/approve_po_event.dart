part of 'approve_po_bloc.dart';

sealed class ApprovePoEvent extends Equatable {
  const ApprovePoEvent();

  @override
  List<Object> get props => [];
}

final class ApprovePoLoadEvent extends ApprovePoEvent {
  final String poId;
  final String status;
  final String typeAprv;
  const ApprovePoLoadEvent({
    required this.poId,
    required this.status,
    required this.typeAprv,
  });
}
