part of 'house_item_with_spk_bloc.dart';

sealed class HouseItemWithSpkState extends Equatable {
  const HouseItemWithSpkState();

  @override
  List<Object> get props => [];
}

final class HouseItemWithSpkInitial extends HouseItemWithSpkState {}

final class HouseItemWithSpkLoading extends HouseItemWithSpkState {}

final class HouseItemWithSpkLoaded extends HouseItemWithSpkState {
  final List<HouseItemSpk> items;
  const HouseItemWithSpkLoaded({required this.items});
}

final class HouseItemWithSpkFailure extends HouseItemWithSpkState {
  final String message;
  final Exception exception;
  const HouseItemWithSpkFailure({
    required this.message,
    required this.exception,
  });
}
