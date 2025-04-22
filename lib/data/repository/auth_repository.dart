import 'package:dartz/dartz.dart';

import '../../models/auth.dart';
import '../../models/errors/custom_exception.dart';
import '../data_providers/rest_api/auth_rest.dart';
import '../data_providers/shared-preferences/shared_preferences_manager.dart';

class AuthRepository {
  final AuthRest authRest;
  final SharedPreferencesManager authSharedPref;

  AuthRepository({required this.authRest, required this.authSharedPref});

  Future<Either<CustomException, Auth>> login({
    required String username,
    required String password,
    // required String shif,
  }) async {
    final res = await authRest.login(
      username: username,
      password: password,
      // shif: shif,
    );
    return res.fold(
      (exception) {
        return Left(exception);
      },
      (auth) {
        authSharedPref.write(auth.toJson());
        return Right(auth);
      },
    );
  }

  Future<Either<CustomException, void>> logout() async {
    final res = await authRest.logout();
    return res.fold(
      (exception) {
        return Left(exception);
      },
      (auth) {
        authSharedPref.clear();
        return Right(null);
      },
    );
  }
}
