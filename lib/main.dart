import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/auth/authentication/authentication_bloc.dart';
import 'data/data_providers/rest_api/auth_rest.dart';
import 'data/data_providers/rest_api/fdpi/fdpi_rest.dart';
import 'data/data_providers/shared-preferences/shared_preferences_key.dart';
import 'data/data_providers/shared-preferences/shared_preferences_manager.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/fdpi_repository.dart';
import 'environment.dart';
import 'presentation/driver/driver_dashboard_screen.dart';
import 'presentation/login/login_form_screen.dart';
import 'utils/interceptors/dio_request_token_interceptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );

  final authSharedPref = SharedPreferencesManager(
    key: SharedPreferencesKey.authKey,
  );

  final dioClient = Dio(Environment.dioBaseOptions)
    ..interceptors.addAll([DioRequestTokenInterceptor()]);

  final authRest = AuthRest(dioClient);
  final fdpiRest = FdpiRest(dioClient);

  final authRepository = AuthRepository(
    authRest: authRest,
    authSharedPref: authSharedPref,
  );
  final fdpiRepository = FdpiRepository(fdpiRest: fdpiRest);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: fdpiRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(lazy: false, create: (context) => AuthenticationBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 972),
      minTextAdapt: true,
      builder:
          (context, widget) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Viva Kencana Ekspedisi',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              primaryColor: Color(0xFF1C3FAA),
              hintColor: Color(0xffF1F1F1),
              disabledColor: Color(0xff808186),
              secondaryHeaderColor: Color(0xff575353),
              fontFamily: "Poppins",
              textTheme: TextTheme(
                labelSmall: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                ),
                labelMedium: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
                labelLarge: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                headlineLarge: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              iconTheme: IconThemeData(color: Color(0xFF1C3FAA)),
            ),

            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  if (true) {
                    return DriverDashboardScreen();
                  }
                }
                return LoginFormScreen();
              },
            ),
          ),
    );
  }
}
