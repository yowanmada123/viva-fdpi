part of 'spk_list_bloc.dart';

sealed class SpkListEvent extends Equatable {
  const SpkListEvent();

  @override
  List<Object> get props => [];
}

class GetSPKList extends SpkListEvent {
  final String idSite;
  final String idCluster;

  const GetSPKList({required this.idSite, required this.idCluster});

  @override
  List<Object> get props => [idSite, idCluster];
}
