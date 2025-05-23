part of 'spk_checklist_bloc.dart';

sealed class SpkChecklistEvent extends Equatable {
  const SpkChecklistEvent();

  @override
  List<Object> get props => [];
}

class LoadSpkChecklist extends SpkChecklistEvent {
  final String qcTransId;

  const LoadSpkChecklist({required this.qcTransId});
}
