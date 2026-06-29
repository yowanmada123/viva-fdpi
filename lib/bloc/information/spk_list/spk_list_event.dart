part of 'spk_list_bloc.dart';

sealed class SpkListEvent extends Equatable {
  const SpkListEvent();

  @override
  List<Object> get props => [];
}

class GetSpkList extends SpkListEvent {
  final String idSite;
  final String idCluster;
  final String idHouse;
  final String spkType;

  const GetSpkList({
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
    required this.spkType,
  });
}
