part of 'bank_bloc.dart';

sealed class BankState extends Equatable {
  const BankState();

  @override
  List<Object> get props => [];
}

final class BankInitial extends BankState {}

final class BankLoadSuccess extends BankState {
  final List<Bank> banks;

  const BankLoadSuccess({required this.banks});

  @override
  List<Object> get props => [banks];
}

final class BankLoadFailure extends BankState {
  final String message;
  final Exception exception;

  const BankLoadFailure({required this.message, required this.exception});

  @override
  List<Object> get props => [message, exception];
}

final class BankLoading extends BankState {}
