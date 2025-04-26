import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../data/data_providers/shared-preferences/shared_preferences_key.dart';
import '../../data/data_providers/shared-preferences/shared_preferences_manager.dart';
import '../../models/auth.dart';

class DioRequestTokenInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final sharedPreferencesManager = SharedPreferencesManager(
      key: SharedPreferencesKey.authKey,
    );

    if (options.headers.containsKey("requiresToken")) {
      options.headers.remove("requiresToken");
      if (await sharedPreferencesManager.hasData()) {
        // print(await sharedPreferencesManager.read());
        final stringData = await sharedPreferencesManager.read();
        final auth = Auth.fromMap(json.decode(stringData!));
        options.headers.addAll({"Authorization": "Bearer ${auth.accessToken}"});
      }
    }
    return handler.next(options);
  }
}
