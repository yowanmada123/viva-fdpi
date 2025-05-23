part of 'spr_list_bloc.dart';

sealed class SprListEvent extends Equatable {
  const SprListEvent();

  @override
  List<Object> get props => [];
}

class GetSPRList extends SprListEvent {
  final String idSite;
  final String idCluster;
  final String idHouse;

  const GetSPRList({
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
  });
}
