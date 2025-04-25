import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../models/user.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthRepository authRest;

  LoginFormBloc(this.authRest) : super(LoginFormInitial()) {
    on<LoginFormSubmitted>((event, emit) async {
      emit(LoginFormLoading());

      final result = await authRest.login(
        username: event.username,
        password: event.password,
        // shif: event.shif,
      );

      result.fold(
        (error) {
          emit(LoginFormError(message: error.message!));
        },
        (auth) {
          emit(LoginFormSuccess(user: auth.user, token: auth.accessToken));
        },
      );
    });

    //     on<LoginFormLogout>((event, emit) async {
    //       emit(LoginFormLoading());

    //       final result = await authRest.logout();

    //       result.fold(
    //         (error) {
    //           emit(LoginFormError(message: error.message!));
    //         },
    //         (_) {
    //           emit(LoginFormInitial());
    //         },
    //       );
    //     });
  }
}
