import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<CheckForUpdate>(_onCheckForUpdate);
    on<DownloadUpdate>(_onDownloadUpdate);
  }

  Future<void> _onCheckForUpdate(
    CheckForUpdate event,
    Emitter<UpdateState> emit,
  ) async {
    try {
      emit(UpdateChecking());

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final dio = Dio();
      final response = await dio.get(
        'https://android.kencana.org/Fasindo/version.json',
      );
      final latestVersion = response.data['latest_version'];
      final apkUrl = response.data['apk_url'];
      final updateNotes = response.data['update_notes'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('latest_version', latestVersion);

      if (latestVersion != currentVersion) {
        emit(
          UpdateAvailable(
            latestVersion: latestVersion,
            apkUrl: apkUrl,
            updateNotes: updateNotes,
          ),
        );
      } else {
        emit(UpdateNotAvailable());
      }
    } catch (e) {
      emit(UpdateError("Gagal memeriksa versi: ${e.toString()}"));
    }
  }

  Future<void> _onDownloadUpdate(
    DownloadUpdate event,
    Emitter<UpdateState> emit,
  ) async {
    try {
      final tempDir = await getExternalStorageDirectory();
      final filePath = '${tempDir!.path}/update.apk';

      await Dio().download(
        event.apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            emit(UpdateDownloading(progress));
          }
        },
      );

      emit(UpdateDownloaded(filePath));
    } catch (e) {
      emit(UpdateError("Gagal mengunduh update: ${e.toString()}"));
    }
  }

  bool isLowerVersion(String current, String latest) {
    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();

    for (var i = 0; i < latestParts.length; i++) {
      final curr = i < currentParts.length ? currentParts[i] : 0;
      final lat = latestParts[i];

      if (curr < lat) return true;
      if (curr > lat) return false;
    }
    return false;
  }
}
