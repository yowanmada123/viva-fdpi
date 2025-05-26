part of 'vendor_bloc.dart';

sealed class VendorState extends Equatable {
  const VendorState();

  @override
  List<Object> get props => [];
}

final class VendorInitial extends VendorState {}

final class VendorLoading extends VendorState {}

final class VendorLoadSuccess extends VendorState {
  final List<Vendor> vendors;
  const VendorLoadSuccess({required this.vendors});
}

final class VendorLoadFailure extends VendorState {
  final Exception exception;
  final String message;
  const VendorLoadFailure({required this.exception, required this.message});
}
