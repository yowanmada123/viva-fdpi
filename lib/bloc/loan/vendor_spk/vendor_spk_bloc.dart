import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/loan_repository.dart';
import '../../../models/loan/vendor_spk.dart';

part 'vendor_spk_event.dart';
part 'vendor_spk_state.dart';

class VendorSpkBloc extends Bloc<VendorSpkEvent, VendorSpkState> {
  final LoanRepository loanRepository;

  VendorSpkBloc({required this.loanRepository}) : super(VendorSpkInitial()) {
    on<VendorSpkLoadEvent>(_onVendorSpkLoadEvent);
  }

  Future<void> _onVendorSpkLoadEvent(
    VendorSpkLoadEvent event,
    Emitter<VendorSpkState> emit,
  ) async {
    emit(VendorSpkLoading());
    final result = await loanRepository.getVendorSpk(
      vendorId: event.vendorId,
      activeFlag: event.activeFlag,
    );
    result.fold(
      (error) =>
          emit(VendorSpkLoadFailure(exception: error, message: error.message!)),
      (data) => emit(VendorSpkLoadSuccess(vendorSpks: data)),
    );
  }
}
