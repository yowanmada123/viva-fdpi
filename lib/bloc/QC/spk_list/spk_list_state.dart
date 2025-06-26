part of 'spk_list_bloc.dart';

sealed class SpkListState extends Equatable {
  const SpkListState();

  @override
  List<Object> get props => [];
}

final class SpkListInitial extends SpkListState {}

final class SpkListLoading extends SpkListState {}

final class SpkListLoadSuccess extends SpkListState {
  final List<SPKGroupedByClusterHome> spkList;

  const SpkListLoadSuccess({required this.spkList});

  @override
  List<Object> get props => [spkList];
}

final class SpkListLoadFailure extends SpkListState {
  final String message;
  final Exception error;

  const SpkListLoadFailure({required this.message, required this.error});

  @override
  List<Object> get props => [message, error];
}
