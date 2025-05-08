part of 'checklist_bloc.dart';

sealed class ChecklistEvent extends Equatable {
  const ChecklistEvent();

  @override
  List<Object> get props => [];
}

class LoadChecklist extends ChecklistEvent {
  final String qcTransId;

  const LoadChecklist({required this.qcTransId});

  @override
  List<Object> get props => [qcTransId];
}
