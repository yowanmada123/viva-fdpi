import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(NotAuthenticated()) {
    on<SetAuthenticationStatus>(_setAuthenticationStatus);
  }

  void _setAuthenticationStatus(
    SetAuthenticationStatus event,
    Emitter<AuthenticationState> emit,
  ) {
    if (event.isAuthenticated && event.user != null) {
      emit(Authenticated(user: event.user!, token: event.token!));
    } else {
      emit(NotAuthenticated());
    }
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    if (json['authUser'] != null) {
      return Authenticated(
        user: User.fromJson(json['authUser']),
        token: json['token'],
      );
    }
    return NotAuthenticated();
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    if (state is Authenticated) {
      return {'authUser': state.user.toJson(), 'token': state.token};
    }
    return null;
  }
}
