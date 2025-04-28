part of 'site_bloc.dart';

sealed class SiteEvent extends Equatable {
  const SiteEvent();

  @override
  List<Object> get props => [];
}

final class GetSites extends SiteEvent {
  final String idProvCity;
  final String idProv;
  final String status;

  const GetSites(this.idProvCity, this.idProv, this.status);

  @override
  List<Object> get props => [idProvCity, idProv, status];
}
