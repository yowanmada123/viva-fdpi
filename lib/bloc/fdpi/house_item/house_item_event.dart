part of 'house_item_bloc.dart';

sealed class HouseItemEvent extends Equatable {
  const HouseItemEvent();

  @override
  List<Object> get props => [];
}

class GetHouseItem extends HouseItemEvent {
  final String idProvince;
  final String idProvCity;
  final String idSite;
  final String idCluster;
  final String category;
  final String status;
  final String idHouseType;

  const GetHouseItem(
    this.idProvince,
    this.idProvCity,
    this.idSite,
    this.idCluster,
    this.category,
    this.status,
    this.idHouseType,
  );

  @override
  List<Object> get props => [
    idProvince,
    idProvCity,
    idSite,
    idCluster,
    category,
    status,
    idHouseType,
  ];
}
