part of 'site_bloc.dart';

sealed class SiteState extends Equatable {
  const SiteState();

  @override
  List<Object> get props => [];
}

final class SiteInitial extends SiteState {}

final class SiteLoadedSuccess extends SiteState {
  final List<Site> sites;

  const SiteLoadedSuccess({required this.sites});

  @override
  List<Object> get props => [sites];
}

final class SiteLoadedFailure extends SiteState {
  final String errorMessage;
  final Exception exception;

  const SiteLoadedFailure({
    required this.errorMessage,
    required this.exception,
  });

  @override
  List<Object> get props => [errorMessage, exception];
}

final class SiteLoading extends SiteState {}
