part of 'approval_spk_list_bloc.dart';

sealed class ApprovalSpkListEvent extends Equatable {
  const ApprovalSpkListEvent();

  @override
  List<Object> get props => [];
}

class GetSpkListEvent extends ApprovalSpkListEvent {
  final String idSite;
  final String idCluster;
  final String idHouse;
  final String approvalType;
  final String approvalStatus;

  const GetSpkListEvent({
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
    required this.approvalType,
    required this.approvalStatus,
  });
}

class RemoveListIndex extends ApprovalSpkListEvent {
  final int index;

  const RemoveListIndex({required this.index});
}
