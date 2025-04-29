part of 'house_item_bloc.dart';

sealed class HouseItemState extends Equatable {
  const HouseItemState();

  @override
  List<Object> get props => [];
}

final class HouseItemInitial extends HouseItemState {}

final class HouseItemLoading extends HouseItemState {}

final class HouseItemLoadSuccess extends HouseItemState {
  final List<HouseItem> houseItems;

  const HouseItemLoadSuccess({required this.houseItems});

  @override
  List<Object> get props => [houseItems];
}

final class HouseItemLoadFailure extends HouseItemState {
  final String message;
  final Exception exception;

  const HouseItemLoadFailure({required this.message, required this.exception});

  @override
  List<Object> get props => [message, exception];
}
