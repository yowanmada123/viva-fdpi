part of 'spk_type_bloc.dart';

sealed class SpkTypeState extends Equatable {
  const SpkTypeState();

  @override
  List<Object> get props => [];
}

final class SpkTypeInitial extends SpkTypeState {}

final class SpkTypeLoading extends SpkTypeState {}

final class SpkTypeLoadedSuccess extends SpkTypeState {
  final List<SpkType> spkTypes;
  final List<Employee> employees;
  final List<Contractor> contractors;

  const SpkTypeLoadedSuccess({
    required this.spkTypes,
    required this.employees,
    required this.contractors,
  });

  @override
  List<Object> get props => [spkTypes, employees, contractors];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpkTypeLoadedSuccess &&
          runtimeType == other.runtimeType &&
          spkTypes == other.spkTypes &&
          employees == other.employees &&
          contractors == other.contractors;

  @override
  int get hashCode =>
      spkTypes.hashCode ^ employees.hashCode ^ contractors.hashCode;
}

final class SpkTypeLoadedFailure extends SpkTypeState {
  final String errorMessage;
  final Exception exception;

  const SpkTypeLoadedFailure({
    required this.errorMessage,
    required this.exception,
  });

  @override
  List<Object> get props => [errorMessage, exception];
}
