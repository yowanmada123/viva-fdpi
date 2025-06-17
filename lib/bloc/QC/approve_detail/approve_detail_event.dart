part of 'approve_detail_bloc.dart';

sealed class ApproveDetailEvent extends Equatable {
  const ApproveDetailEvent();

  @override
  List<Object> get props => [];
}

class ApproveDetailEventInit extends ApproveDetailEvent {}

class LoadApproveDetail extends ApproveDetailEvent {
  String qcTransId;
  String idQcItem;
  String idWork;

  LoadApproveDetail({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
  });
}
