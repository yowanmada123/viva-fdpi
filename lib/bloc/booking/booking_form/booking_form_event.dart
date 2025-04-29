part of 'booking_form_bloc.dart';

sealed class BookingFormEvent extends Equatable {
  const BookingFormEvent();

  @override
  List<Object> get props => [];
}

class SubmitBookingForm extends BookingFormEvent {
  final String namaCustomer;
  final String alamatCustomer;
  final String nomorHp;
  final String telepon;
  final String houseItem;
  final String priceList;
  final String discount;
  final String payterm;
  final String bank;
  final String expDate;
  final String remark;

  const SubmitBookingForm({
    required this.namaCustomer,
    required this.alamatCustomer,
    required this.nomorHp,
    required this.telepon,
    required this.houseItem,
    required this.priceList,
    required this.discount,
    required this.payterm,
    required this.bank,
    required this.expDate,
    required this.remark,
  });

  @override
  List<Object> get props => [
    namaCustomer,
    alamatCustomer,
    nomorHp,
    telepon,
    houseItem,
    priceList,
    discount,
    payterm,
    bank,
    expDate,
    remark,
  ];
}
