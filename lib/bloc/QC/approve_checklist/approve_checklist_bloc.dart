import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/repository/spk_repository.dart';
import '../../../models/attachment.dart';

part 'approve_checklist_event.dart';
part 'approve_checklist_state.dart';

class ApproveChecklistBloc
    extends Bloc<ApproveChecklistEvent, ApproveChecklistState> {
  final SPKRepository spkRepository;

  ApproveChecklistBloc({required this.spkRepository})
    : super(ApproveChecklistInitial()) {
    on<ApproveChecklistEventInit>(_approveChecklistEventInit);
    on<ApproveChecklistCancel>(_approveChecklistCancel);
    on<ApproveChecklistUpdate>(_onUpdateApproveChecklist);
  }

  Future<bool> _checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Izin lokasi tidak diberikan.');
    }

    return true;
  }

  Future<void> _checkLocationRequirements() async {
    final granted = await _checkAndRequestPermission();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!granted) {
      await Geolocator.openAppSettings();
      throw Exception('Izin lokasi tidak diberikan');
    }

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Layanan lokasi tidak aktif');
    }
  }

  Future<Position> _getCurrentLocation() async {
    final locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }

  Future<void> _approveChecklistEventInit(
    ApproveChecklistEventInit event,
    Emitter<ApproveChecklistState> emit,
  ) async {
    try {
      emit(ApproveChecklistLoading());

      final position = await _getCurrentLocation();
      await _checkLocationRequirements();

      final result = await spkRepository.approveChecklist(
        qcTransId: event.qcTransId,
        idQcItem: event.idQcItem,
        remark: event.remark ?? "",
        fileImage: event.fileImage,
        idWork: event.idWork,
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
      result.fold(
        (failure) => emit(
          ApproveChecklistLoadFailure(
            message: failure.message!,
            error: failure,
          ),
        ),
        (data) => emit(ApproveChecklistLoadSuccess(message: data)),
      );
    } on Exception catch (e, s) {
      emit(ApproveChecklistLoadFailure(message: e.toString(), error: e));
    }
  }

  Future<void> _approveChecklistCancel(
    ApproveChecklistCancel event,
    Emitter<ApproveChecklistState> emit,
  ) async {
    emit(ApproveChecklistLoading());
    final result = await spkRepository.unapproveChecklist(
      qcTransId: event.qcTransId,
      idQcItem: event.idQcItem,
      idWork: event.idWork,
    );
    result.fold(
      (failure) => emit(
        ApproveChecklistLoadFailure(message: failure.message!, error: failure),
      ),
      (data) => emit(ApproveChecklistLoadSuccess(message: data)),
    );
  }

  Future<void> _onUpdateApproveChecklist(
    ApproveChecklistUpdate event,
    Emitter<ApproveChecklistState> emit,
  ) async {
    try {
      emit(ApproveChecklistLoading());

      final position = await _getCurrentLocation();
      await _checkLocationRequirements();

      final result = await spkRepository.updateApproveChecklist(
        qcTransId: event.qcTransId,
        idQcItem: event.idQcItem,
        idWork: event.idWork,
        remark: event.remark ?? "",
        fileImage: event.fileImage,
        deleteImage: event.deleteImage,
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );
      result.fold(
        (failure) => emit(
          ApproveChecklistLoadFailure(
            message: failure.message!,
            error: failure,
          ),
        ),
        (data) => emit(ApproveChecklistLoadSuccess(message: data)),
      );
    } on Exception catch (e, s) {
      emit(ApproveChecklistLoadFailure(message: e.toString(), error: e));
    }
  }
}
