part of 'approval_spr_detail_bloc.dart';

sealed class ApprovalSprDetailEvent extends Equatable {
  const ApprovalSprDetailEvent();

  @override
  List<Object> get props => [];
}

class ApprovalSprDetailLoad extends ApprovalSprDetailEvent {
  final String idSpr;
  const ApprovalSprDetailLoad({required this.idSpr});
}
