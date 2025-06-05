part of 'vendor_has_spk_bloc.dart';

sealed class VendorHasSpkState extends Equatable {
  const VendorHasSpkState();

  @override
  List<Object> get props => [];
}

final class VendorHasSpkInitial extends VendorHasSpkState {}

final class VendorHasSpkLoading extends VendorHasSpkState {}

final class VendorHasSpkLoadedSuccess extends VendorHasSpkState {
  final List<Vendor> vendors;

  const VendorHasSpkLoadedSuccess({required this.vendors});
}

final class VendorHasSpkLoadFailure extends VendorHasSpkState {
  final String message;
  final Exception exception;

  const VendorHasSpkLoadFailure({
    required this.message,
    required this.exception,
  });
}
