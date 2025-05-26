part of 'vendor_spk_bloc.dart';

sealed class VendorSpkEvent extends Equatable {
  const VendorSpkEvent();

  @override
  List<Object> get props => [];
}

final class VendorSpkLoadEvent extends VendorSpkEvent {
  final String vendorId;
  final String? activeFlag;

  const VendorSpkLoadEvent({required this.vendorId, this.activeFlag});
}
