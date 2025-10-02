import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_loan_rest.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_po.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_pr_rest.dart';
import 'package:fdpi_app/data/data_providers/rest_api/approval/approval_spb_rest.dart';
import 'package:fdpi_app/data/repository/approval_loan_repository.dart';
import 'package:fdpi_app/data/repository/approval_po_repository.dart';
import 'package:fdpi_app/data/repository/approval_pr_repository.dart';
import 'package:fdpi_app/data/repository/approval_spb.dart';
import 'package:fdpi_app/data/repository/approval_spk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/update/update_bloc.dart';
import 'bloc/auth/authentication/authentication_bloc.dart';
import 'bloc/authorization/credentials/credentials_bloc.dart';
import 'data/data_providers/rest_api/approval/approval_spk_rest.dart';
import 'data/data_providers/rest_api/auth_rest.dart';
import 'data/data_providers/rest_api/authorization/authorization_rest.dart';
import 'data/data_providers/rest_api/booking_rest.dart';
import 'data/data_providers/rest_api/fdpi/fdpi_rest.dart';
import 'data/data_providers/rest_api/loan/loan_rest.dart';
import 'data/data_providers/rest_api/master/master_rest.dart';
import 'data/data_providers/rest_api/spk_rest.dart';
import 'data/data_providers/shared-preferences/shared_preferences_key.dart';
import 'data/data_providers/shared-preferences/shared_preferences_manager.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/authorization_repository.dart';
import 'data/repository/booking_repository.dart';
import 'data/repository/fdpi_repository.dart';
import 'data/repository/loan_repository.dart';
import 'data/repository/master_repository.dart';
import 'data/repository/spk_repository.dart';
import 'environment.dart';
import 'presentation/dashboard_screen.dart';
import 'presentation/login/login_form_screen.dart';
import 'utils/interceptors/dio_request_token_interceptor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

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

  final dioFdpiClient = Dio(FpiEnvironment.dioBaseOptions)
    ..interceptors.addAll([DioRequestTokenInterceptor()]);

  final authRest = AuthRest(dioClient);
  final fdpiRest = FdpiRest(dioFdpiClient);
  final authorizationRest = AuthorizationRest(dioClient);
  final bookingRest = BookingRest(dioFdpiClient);
  final masterRest = MasterRest(dioFdpiClient);
  final spkRest = SPKRest(dioFdpiClient);
  final loanRest = LoanRest(dioFdpiClient);
  final approvalSpbRest = ApprovalSpbRest(dioFdpiClient);
  final approvalSpkRest = ApprovalSpkRest(dioFdpiClient);
  final approvalLoanRest = ApprovalLoanRest(dioFdpiClient);
  final approvalPoRest = ApprovalPORest(dioFdpiClient);
  final approvalPrRest = ApprovalPRRest(dioFdpiClient);

  final authRepository = AuthRepository(
    authRest: authRest,
    authSharedPref: authSharedPref,
  );
  final fdpiRepository = FdpiRepository(fdpiRest: fdpiRest);
  final authorizationRepository = AuthorizationRepository(
    authorizationRest: authorizationRest,
  );
  final bookingRepository = BookingRepository(bookingRest: bookingRest);
  final masterRepository = MasterRepository(masterRest: masterRest);
  final spkRepository = SPKRepository(spkRest: spkRest);
  final loanRepostitory = LoanRepository(loanRest: loanRest);
  final approvalSpbRepository = ApprovalSpbRepository(
    approvalSpbRest: approvalSpbRest,
  );
  final approvalSpkRepository = ApprovalSpkRepository(
    approvalSpkRest: approvalSpkRest,
  );
  final approvalLoanRepository = ApprovalLoanRepository(
    approvalLoanRest: approvalLoanRest,
  );
  final approvalPoRepository = ApprovalPORepository(
    approvalPORest: approvalPoRest,
  );
  final approvalPrRepository = ApprovalPRRepository(
    approvalPRRest: approvalPrRest,
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: fdpiRepository),
        RepositoryProvider.value(value: authorizationRepository),
        RepositoryProvider.value(value: bookingRepository),
        RepositoryProvider.value(value: masterRepository),
        RepositoryProvider.value(value: spkRepository),
        RepositoryProvider.value(value: loanRepostitory),
        RepositoryProvider.value(value: approvalSpbRepository),
        RepositoryProvider.value(value: approvalSpkRepository),
        RepositoryProvider.value(value: approvalLoanRepository),
        RepositoryProvider.value(value: approvalPoRepository),
        RepositoryProvider.value(value: approvalPrRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(lazy: false, create: (context) => AuthenticationBloc()),
          BlocProvider(
            lazy: false,
            create: (context) => UpdateBloc()..add(CheckForUpdate()),
          ),
          BlocProvider(
            lazy: false,
            create:
                (context) => CredentialsBloc(
                  authorizationRepository: authorizationRepository,
                ),
          ),
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
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              primaryColor: Color(0xFF1C3FAA),
              hintColor: Color(0xffF1F1F1),
              disabledColor: Color(0xff808186),
              secondaryHeaderColor: Color(0xff575353),
              scaffoldBackgroundColor: Color(0xfff5f5f5),
              appBarTheme: AppBarTheme(
                backgroundColor: Color.fromARGB(255, 245, 245, 245),
                titleTextStyle: TextStyle(
                  color: Color(0xFF1C3FAA),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
                iconTheme: IconThemeData(color: Color(0xFF1C3FAA)),
              ),
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

            home: BlocListener<UpdateBloc, UpdateState>(
              listener: (context, state) {
                if (state is UpdateAvailable) {
                  _showUpdateDialog(context, state);
                } else if (state is UpdateDownloaded) {
                  Navigator.pop(context);
                  OpenFile.open(state.filePath);
                } else if (state is UpdateError) {
                  Navigator.pop(context);
                  _showErrorDialog(context, state.message);
                }
              },
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is Authenticated) {
                    return DriverDashboardScreen();
                  }
                  return LoginFormScreen();
                },
              ),
            ),
          ),
    );
  }

  void _showUpdateDialog(BuildContext context, UpdateAvailable state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: const Text('Update Tersedia'),
              content: Text(
                'Versi ${state.latestVersion} tersedia:\n\n${state.updateNotes}',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => _handleUpdate(context, state),
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _handleUpdate(
    BuildContext context,
    UpdateAvailable state,
  ) async {
    Navigator.pop(context);

    if (!await _checkInstallPermission(context)) return;

    context.read<UpdateBloc>().add(DownloadUpdate(state.apkUrl));

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => PopScope(
            canPop: false,
            child: AlertDialog(
              title: Text(
                "Sedang Memperbarui…",
                style: TextStyle(fontSize: 16.w),
              ),
              content: BlocBuilder<UpdateBloc, UpdateState>(
                buildWhen: (prev, curr) => curr is UpdateDownloading,
                builder: (context, state) {
                  double progress = 0.0;
                  if (state is UpdateDownloading) {
                    progress = state.progress;
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LinearProgressIndicator(value: progress),
                      const SizedBox(height: 12),
                      Text("${(progress * 100).toStringAsFixed(0)}%"),
                    ],
                  );
                },
              ),
            ),
          ),
    );
  }

  Future<bool> _checkStoragePermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 30) {
        final status = await Permission.manageExternalStorage.request();
        if (status.isGranted) return true;
      } else {
        final status = await Permission.storage.request();
        if (status.isGranted) return true;
      }

      _showErrorDialog(context, 'Izin penyimpanan tidak diberikan.');
      return false;
    }

    return true;
  }

  Future<bool> _checkInstallPermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 26) {
        final status = await Permission.requestInstallPackages.request();
        if (status.isGranted) return true;

        _showErrorDialog(
          context,
          'Izin install dari sumber tidak dikenal tidak diberikan.',
        );
        return false;
      }
    }

    return true;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }
}
