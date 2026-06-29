part of 'spk_type_bloc.dart';

sealed class SpkTypeEvent extends Equatable {
  const SpkTypeEvent();

  @override
  List<Object> get props => [];
}

final class GetSpkTypes extends SpkTypeEvent {
  final String keyCode;

  const GetSpkTypes(this.keyCode);

  @override
  List<Object> get props => [keyCode];
}

// TAMBAH:
final class GetEmployee extends SpkTypeEvent {
  const GetEmployee();

  @override
  List<Object> get props => [];
}

final class GetContractor extends SpkTypeEvent {
  const GetContractor();

  @override
  List<Object> get props => [];
}

final class GetAllLookupData extends SpkTypeEvent {
  const GetAllLookupData();

  @override
  List<Object> get props => [];
}
