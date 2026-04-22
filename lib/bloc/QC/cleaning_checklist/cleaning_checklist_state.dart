part of 'cleaning_checklist_bloc.dart';

sealed class CleaningChecklistState extends Equatable {
  const CleaningChecklistState();

  @override
  List<Object> get props => [];
}

final class CleaningChecklistInitial extends CleaningChecklistState {}

final class CleaningChecklistLoading extends CleaningChecklistState {}

final class CleaningChecklistLoadSuccess extends CleaningChecklistState {
  final List<ChecklistCleaningItem> sprChecklistItem;
  const CleaningChecklistLoadSuccess({required this.sprChecklistItem});
}

final class CleaningChecklistLoadFailure extends CleaningChecklistState {
  final String message;
  final Exception exception;
  const CleaningChecklistLoadFailure({
    required this.message,
    required this.exception,
  });
}
