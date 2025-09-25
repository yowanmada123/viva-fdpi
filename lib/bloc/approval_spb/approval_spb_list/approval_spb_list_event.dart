part of 'approval_spb_list_bloc.dart';

sealed class ApprovalSpbListEvent extends Equatable {
  const ApprovalSpbListEvent();

  @override
  List<Object> get props => [];
}

class GetSpbListEvent extends ApprovalSpbListEvent {}

class RemoveListIndex extends ApprovalSpbListEvent {
  final int index;

  const RemoveListIndex({required this.index});
}
