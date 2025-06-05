import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/spk_repository.dart';
import '../../../models/master/vendor.dart';

part 'vendor_has_spk_event.dart';
part 'vendor_has_spk_state.dart';

class VendorHasSpkBloc extends Bloc<VendorHasSpkEvent, VendorHasSpkState> {
  final SPKRepository spkRepository;
  VendorHasSpkBloc({required this.spkRepository})
    : super(VendorHasSpkInitial()) {
    on<GetVendorHasSpkEvent>(_onGetVendorHasSpkEvent);
  }

  Future<void> _onGetVendorHasSpkEvent(
    GetVendorHasSpkEvent event,
    Emitter<VendorHasSpkState> emit,
  ) async {
    emit(VendorHasSpkLoading());
    final result = await spkRepository.getVendorWithSpk();
    result.fold(
      (failure) => emit(
        VendorHasSpkLoadFailure(message: failure.message!, exception: failure),
      ),
      (data) => emit(VendorHasSpkLoadedSuccess(vendors: data)),
    );
  }
}
