part of 'residence_bloc.dart';

class ResidenceState extends Equatable {
  const ResidenceState();

  @override
  List<Object?> get props => [];
}

class ResidenceInitial extends ResidenceState {}

class ResidenceLoading extends ResidenceState {}

class ResidenceLoadSuccess extends ResidenceState {
  final List<Residence> residences;

  const ResidenceLoadSuccess({required this.residences});

  @override
  List<Object?> get props => [residences];
}

class ResidenceLoadFailure extends ResidenceState {
  final String errorMessage;
  final Exception exception;

  const ResidenceLoadFailure({
    required this.errorMessage,
    required this.exception,
  });

  @override
  List<Object?> get props => [errorMessage, exception];
}
