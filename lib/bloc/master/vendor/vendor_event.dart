part of 'vendor_bloc.dart';

sealed class VendorEvent extends Equatable {
  const VendorEvent();

  @override
  List<Object> get props => [];
}

class GetVendor extends VendorEvent {}
