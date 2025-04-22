import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/auth_repository.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository authRepository;

  LogoutBloc(this.authRepository) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());

      final result = await authRepository.logout();

      result.fold(
        (error) {
          emit(LogoutFailure());
        },
        (_) {
          emit(LogoutSuccess());
        },
      );
    });
  }
}
