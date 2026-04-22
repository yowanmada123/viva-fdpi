part of 'cleaning_list_bloc.dart';

sealed class CleaningListEvent extends Equatable {
  const CleaningListEvent();

  @override
  List<Object> get props => [];
}

class GetCleaningList extends CleaningListEvent {
  final String idSite;
  final String idCluster;
  final String idHouse;

  const GetCleaningList({
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
  });
}
