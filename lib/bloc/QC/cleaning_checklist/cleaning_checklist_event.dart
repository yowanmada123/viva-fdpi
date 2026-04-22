part of 'cleaning_checklist_bloc.dart';

sealed class CleaningChecklistEvent extends Equatable {
  const CleaningChecklistEvent();

  @override
  List<Object> get props => [];
}

class LoadCleaningChecklist extends CleaningChecklistEvent {
  final String qcTransId;
  const LoadCleaningChecklist({required this.qcTransId});
}
