import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/master_repository.dart';
import '../../../models/master/vendor.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final MasterRepository masterRepository;

  VendorBloc({required this.masterRepository}) : super(VendorInitial()) {
    on<GetVendor>(_onGetVendor);
  }

  Future<void> _onGetVendor(GetVendor event, Emitter<VendorState> emit) async {
    emit(VendorLoading());
    final result = await masterRepository.getVendor();

    result.fold(
      (failure) => emit(
        VendorLoadFailure(message: failure.message!, exception: failure),
      ),
      (data) => emit(VendorLoadSuccess(vendors: data)),
    );
  }
}
