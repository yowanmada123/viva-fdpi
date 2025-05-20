part of 'approve_checklist_bloc.dart';

sealed class ApproveChecklistEvent extends Equatable {
  const ApproveChecklistEvent();

  @override
  List<Object> get props => [];
}

class ApproveChecklistEventInit extends ApproveChecklistEvent {
  final String qcTransId;
  final String idQcItem;
  final String? remark;
  final String? imgBase64;
  final String idWork;

  const ApproveChecklistEventInit({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
    this.imgBase64,
    this.remark,
  });

  @override
  List<Object> get props => [qcTransId, idQcItem, remark!, imgBase64!, idWork];
}
