part of 'approve_checklist_bloc.dart';

sealed class ApproveChecklistEvent extends Equatable {
  const ApproveChecklistEvent();

  @override
  List<Object> get props => [];
}

class ApproveChecklistEventInit extends ApproveChecklistEvent {
  final qcTransId;
  final idQcItem;
  final remark;
  const ApproveChecklistEventInit({this.qcTransId, this.idQcItem, this.remark});

  @override
  List<Object> get props => [qcTransId, idQcItem, remark];
}
