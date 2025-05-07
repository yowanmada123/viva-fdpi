part of 'checklist_bloc.dart';

sealed class ChecklistState extends Equatable {
  const ChecklistState();

  @override
  List<Object> get props => [];
}

final class ChecklistInitial extends ChecklistState {}

final class ChecklistLoading extends ChecklistState {}

final class ChecklistLoadSuccess extends ChecklistState {
  final Map<String, List<ChecklistItem>> checklistItem;
  const ChecklistLoadSuccess({required this.checklistItem});

  @override
  List<Object> get props => [checklistItem];
}

final class ChecklistLoadFailure extends ChecklistState {
  final String message;
  final Exception error;
  const ChecklistLoadFailure({required this.message, required this.error});

  @override
  List<Object> get props => [message, error];
}
