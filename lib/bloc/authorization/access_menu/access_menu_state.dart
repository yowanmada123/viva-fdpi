part of 'access_menu_bloc.dart';

sealed class AccessMenuState extends Equatable {
  const AccessMenuState();

  @override
  List<Object> get props => [];
}

final class AccessMenuInitial extends AccessMenuState {}

final class AccessMenuLoadSuccess extends AccessMenuState {
  final List<Menu> menus;

  const AccessMenuLoadSuccess({required this.menus});

  @override
  List<Object> get props => [menus];
}

final class AccessMenuLoadFailure extends AccessMenuState {
  final String errorMessage;
  final Exception exception;

  const AccessMenuLoadFailure({
    required this.errorMessage,
    required this.exception,
  });

  @override
  List<Object> get props => [errorMessage, exception];
}

final class AccessMenuLoading extends AccessMenuState {}
