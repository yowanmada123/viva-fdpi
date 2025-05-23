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
  final MultipartFile? fileImage;
  final String idWork;

  const ApproveChecklistEventInit({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
    this.fileImage,
    this.remark,
  });
}
