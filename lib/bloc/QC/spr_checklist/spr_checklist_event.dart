part of 'spr_checklist_bloc.dart';

sealed class SprChecklistEvent extends Equatable {
  const SprChecklistEvent();

  @override
  List<Object> get props => [];
}

class LoadSprChecklist extends SprChecklistEvent {
  final String qcTransId;
  const LoadSprChecklist({required this.qcTransId});
}
