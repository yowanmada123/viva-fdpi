part of 'house_item_with_spk_bloc.dart';

sealed class HouseItemWithSpkEvent extends Equatable {
  const HouseItemWithSpkEvent();

  @override
  List<Object> get props => [];
}

class GetHouseItemWithSpkEvent extends HouseItemWithSpkEvent {
  final String idSite;
  final String idCluster;
  final String docType;
  final String? activeFlag;

  const GetHouseItemWithSpkEvent({
    required this.idSite,
    required this.idCluster,
    required this.docType,
    this.activeFlag,
  });

  @override
  List<Object> get props => [idSite, idCluster, docType];
}
