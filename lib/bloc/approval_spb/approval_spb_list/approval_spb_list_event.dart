part of 'approval_spb_list_bloc.dart';

sealed class ApprovalSpbListEvent extends Equatable {
  const ApprovalSpbListEvent();

  @override
  List<Object> get props => [];
}

class GetSpbListEvent extends ApprovalSpbListEvent {}
