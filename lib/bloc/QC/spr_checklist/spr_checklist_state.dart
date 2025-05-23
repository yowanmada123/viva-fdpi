part of 'spr_checklist_bloc.dart';

sealed class SprChecklistState extends Equatable {
  const SprChecklistState();

  @override
  List<Object> get props => [];
}

final class SprChecklistInitial extends SprChecklistState {}

final class SprChecklistLoading extends SprChecklistState {}

final class SprChecklistLoadSuccess extends SprChecklistState {
  final List<ChecklistSprItem> sprChecklistItem;
  const SprChecklistLoadSuccess({required this.sprChecklistItem});
}

final class SprChecklistLoadFailure extends SprChecklistState {
  final String message;
  final Exception exception;
  const SprChecklistLoadFailure({
    required this.message,
    required this.exception,
  });
}
