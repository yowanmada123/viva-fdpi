part of 'spk_list_bloc.dart';

sealed class SpkListEvent extends Equatable {
  const SpkListEvent();

  @override
  List<Object> get props => [];
}

class GetSPKList extends SpkListEvent {
  final String idVendor;
  final String idSite;
  final String idCluster;
  final String idHouse;

  const GetSPKList({
    required this.idVendor,
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
  });

  @override
  List<Object> get props => [idVendor, idSite, idCluster];
}
