part of 'vendor_has_spk_bloc.dart';

sealed class VendorHasSpkEvent extends Equatable {
  const VendorHasSpkEvent();

  @override
  List<Object> get props => [];
}

class GetVendorHasSpkEvent extends VendorHasSpkEvent {}
