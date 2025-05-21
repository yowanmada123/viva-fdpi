import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/authorization_repository.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final AuthorizationRepository authorizationRepository;

  CredentialsBloc({required this.authorizationRepository})
    : super(CredentialsInitial()) {
    on<CredentialsLoad>(_onLoadCredentials);
  }

  Future<void> _onLoadCredentials(
    CredentialsLoad event,
    Emitter<CredentialsState> emit,
  ) async {
    final result = await authorizationRepository.getConv(
      event.entityId,
      event.applId,
    );

    result.fold(
      (error) => emit(
        CredentialsLoadFailure(errorMessage: error.message!, exception: error),
      ),
      (data) {
        return emit(CredentialsLoadSuccess(credentials: data));
      },
    );
  }
}
