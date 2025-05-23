part of 'spk_checklist_bloc.dart';

sealed class SpkChecklistState extends Equatable {
  const SpkChecklistState();

  @override
  List<Object> get props => [];
}

final class SpkChecklistInitial extends SpkChecklistState {}

final class SpkChecklistLoading extends SpkChecklistState {}

final class SpkChecklistLoadSuccess extends SpkChecklistState {
  final List<ChecklistSpkProgress> checklistItem;
  const SpkChecklistLoadSuccess({required this.checklistItem});
}

final class SpkChecklistLoadFailure extends SpkChecklistState {
  final String message;
  final Exception error;
  const SpkChecklistLoadFailure({required this.message, required this.error});
}
