part of 'checklist_bloc.dart';

sealed class ChecklistEvent extends Equatable {
  const ChecklistEvent();

  @override
  List<Object> get props => [];
}

class LoadChecklist extends ChecklistEvent {
  final String idHouse;
  final String clType;

  const LoadChecklist({required this.idHouse, required this.clType});

  @override
  List<Object> get props => [idHouse, clType];
}
