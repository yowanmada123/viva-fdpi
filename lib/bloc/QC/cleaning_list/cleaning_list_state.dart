part of 'cleaning_list_bloc.dart';

sealed class CleaningListState extends Equatable {
  const CleaningListState();

  @override
  List<Object> get props => [];
}

final class CleaningListInitial extends CleaningListState {}

final class CleaningListLoading extends CleaningListState {}

final class CleaningListLoadSuccess extends CleaningListState {
  final List<Cleaning> cleaningList;

  const CleaningListLoadSuccess({required this.cleaningList});

  @override
  List<Object> get props => [cleaningList];
}

final class CleaningListLoadFailure extends CleaningListState {
  final String message;
  final Exception error;

  const CleaningListLoadFailure({required this.message, required this.error});

  @override
  List<Object> get props => [message, error];
}
