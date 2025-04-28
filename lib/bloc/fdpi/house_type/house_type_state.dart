part of 'house_type_bloc.dart';

sealed class HouseTypeState extends Equatable {
  const HouseTypeState();

  @override
  List<Object> get props => [];
}

final class HouseTypeInitial extends HouseTypeState {}

final class HouseTypeLoadSuccess extends HouseTypeState {
  final List<HouseType> houseTypes;

  const HouseTypeLoadSuccess({required this.houseTypes});

  @override
  List<Object> get props => [houseTypes];
}

final class HouseTypeLoadFailure extends HouseTypeState {
  final String message;
  final Exception exception;

  const HouseTypeLoadFailure({required this.message, required this.exception});

  @override
  List<Object> get props => [message, exception];
}

final class HouseTypeLoading extends HouseTypeState {}
