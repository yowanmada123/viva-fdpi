part of 'approval_spr_list_bloc.dart';

sealed class ApprovalSprListEvent extends Equatable {
  const ApprovalSprListEvent();

  @override
  List<Object> get props => [];
}

class GetSprListEvent extends ApprovalSprListEvent {}

class RemoveListIndex extends ApprovalSprListEvent {
  final int index;

  const RemoveListIndex({required this.index});
}
