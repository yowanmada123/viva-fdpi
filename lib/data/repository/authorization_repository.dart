import 'package:dartz/dartz.dart';
import 'package:fdpi_app/data/data_providers/rest_api/authorization/authorization_rest.dart';
import 'package:fdpi_app/models/authorization/menu.dart';

import '../../models/errors/custom_exception.dart';

class AuthorizationRepository {
  final AuthorizationRest authorizationRest;

  AuthorizationRepository({required this.authorizationRest});

  Future<Either<CustomException, List<Menu>>> getMenu(
    String entityId,
    String applId,
  ) async {
    return authorizationRest.getMenus(entityId: entityId, applId: applId);
  }

  Future<Either<CustomException, Map<String, String>>> getConv(
    String entityId,
    String applId,
  ) async {
    return authorizationRest.getConv(entityId: entityId, applId: applId);
  }
}
