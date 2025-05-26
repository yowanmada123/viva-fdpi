part of 'vendor_spk_bloc.dart';

sealed class VendorSpkState extends Equatable {
  const VendorSpkState();

  @override
  List<Object> get props => [];
}

final class VendorSpkInitial extends VendorSpkState {}

final class VendorSpkLoading extends VendorSpkState {}

final class VendorSpkLoadSuccess extends VendorSpkState {
  final List<VendorSpk> vendorSpks;
  const VendorSpkLoadSuccess({required this.vendorSpks});
}

final class VendorSpkLoadFailure extends VendorSpkState {
  final Exception exception;
  final String message;

  const VendorSpkLoadFailure({required this.exception, required this.message});
}
