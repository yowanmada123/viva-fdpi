part of 'approval_spb_detail_bloc.dart';

sealed class ApprovalSpbDetailEvent extends Equatable {
  const ApprovalSpbDetailEvent();

  @override
  List<Object> get props => [];
}

class ApprovalSpbDetailLoad extends ApprovalSpbDetailEvent {
  final String idSpb;
  const ApprovalSpbDetailLoad({required this.idSpb});
}
