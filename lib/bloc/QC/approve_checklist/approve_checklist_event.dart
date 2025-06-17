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
  final List<Attachment>? fileImage;
  final String idWork;

  const ApproveChecklistEventInit({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
    this.fileImage,
    this.remark,
  });
}

class ApproveChecklistCancel extends ApproveChecklistEvent {
  final String qcTransId;
  final String idQcItem;
  final String idWork;

  const ApproveChecklistCancel({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
  });
}

class ApproveChecklistUpdate extends ApproveChecklistEvent {
  final String qcTransId;
  final String idQcItem;
  final String idWork;
  final String remark;
  final List<Attachment>? fileImage;
  final List<String> deleteImage;

  const ApproveChecklistUpdate({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
    required this.remark,
    required this.fileImage,
    required this.deleteImage,
  });
}
