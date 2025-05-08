part of 'spr_list_bloc.dart';

sealed class SprListState extends Equatable {
  const SprListState();

  @override
  List<Object> get props => [];
}

final class SprListInitial extends SprListState {}

final class SprListLoading extends SprListState {}

final class SprListLoadSuccess extends SprListState {
  final List<SPR> sprList;

  const SprListLoadSuccess({required this.sprList});

  @override
  List<Object> get props => [sprList];
}

final class SprListLoadFailure extends SprListState {
  final String message;
  final Exception error;

  const SprListLoadFailure({required this.message, required this.error});

  @override
  List<Object> get props => [message, error];
}
