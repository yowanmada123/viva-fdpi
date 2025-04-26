part of 'house_type_bloc.dart';

sealed class HouseTypeEvent extends Equatable {
  const HouseTypeEvent();

  @override
  List<Object> get props => [];
}

class GetHouseTypesEvent extends HouseTypeEvent {
  final String idSite;
  final String houseCategory;
  final String status;

  const GetHouseTypesEvent({
    required this.idSite,
    required this.houseCategory,
    required this.status,
  });

  @override
  List<Object> get props => [idSite, houseCategory, status];
}
