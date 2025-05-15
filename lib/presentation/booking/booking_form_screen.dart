import 'package:fdpi_app/bloc/booking/booking_list/booking_bloc.dart';
import 'package:fdpi_app/bloc/fdpi/house_item/house_item_bloc.dart';
import 'package:fdpi_app/data/repository/booking_repository.dart';
import 'package:fdpi_app/models/bank.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:fdpi_app/models/fdpi/house_item.dart';
import 'package:fdpi_app/models/fdpi/site.dart';
import 'package:fdpi_app/presentation/widgets/MoneyInputWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/booking/booking_form/booking_form_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../bloc/fdpi/site/site_bloc.dart';
import '../../bloc/master/bank/bank_bloc.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../data/repository/master_repository.dart';
import '../../models/fdpi/residence.dart';

class BookingFormScreen extends StatelessWidget {
  final BookingBloc bookingBloc;
  const BookingFormScreen({super.key, required this.bookingBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: bookingBloc),
        BlocProvider(
          create:
              (context) =>
                  ResidenceBloc(fdpiRepository: context.read<FdpiRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  SiteBloc(fdpiRepository: context.read<FdpiRepository>())
                    ..add(GetSites("", "", "")),
        ),
        BlocProvider(
          create:
              (context) =>
                  HouseItemBloc(fdpiRepository: context.read<FdpiRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  BankBloc(masterRest: context.read<MasterRepository>())
                    ..add(GetBank()),
        ),
        BlocProvider(
          create:
              (context) => BookingFormBloc(
                bookingRepository: context.read<BookingRepository>(),
              ),
        ),
      ],
      child: const BookingFormView(),
    );
  }
}

class BookingFormView extends StatefulWidget {
  const BookingFormView({super.key});

  @override
  State<BookingFormView> createState() => _BookingFormViewState();
}

class _BookingFormViewState extends State<BookingFormView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  final TextEditingController _priceListController = TextEditingController();
  final TextEditingController _expDateController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  Site? _selectedSite;
  Residence? _selectedCluster;
  HouseItem? _selectedHouseItem;
  String? _selectedPaymentTerm;
  Bank? _selectedBank;

  List<String> sites = ['Site A', 'Site B', 'Site C'];
  List<String> clusters = ['Cluster X', 'Cluster Y', 'Cluster Z'];
  List<String> houseItems = ['Type 1', 'Type 2', 'Type 3'];
  List<String> paymentTerms = ['KPR', 'SOFT CASH', 'HARD CASH'];
  List<String> banks = ['BCA', 'Mandiri', 'BNI', 'BRI'];

  final _phoneFormatter = MaskTextInputFormatter(
    mask: '####-####-######',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    _teleponController.dispose();
    _priceListController.dispose();
    _expDateController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text, {bool required = true}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: RichText(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          children: [
            if (required)
              const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    TextInputType? keyboardType,
    bool readOnly = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    int? maxLines = 1,
    MaskTextInputFormatter? formatter,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: UnderlineInputBorder(),
        suffixIcon: suffixIcon,
        fillColor: const Color(0xffffffff),
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: maxLines == 1 ? 0 : 12.h,
        ),
      ),
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      maxLines: maxLines,
      inputFormatters: formatter != null ? [formatter] : null,
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required List<T> items,
    required String Function(T) itemBuilder,
    required T? value,
    required void Function(T?) onChanged,
    String? Function(T?)? validator,
    bool required = true,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        fillColor: const Color(0xffffffff),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
      items:
          items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemBuilder(item)),
            );
          }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Form')),
      body: BlocConsumer<BookingFormBloc, BookingFormState>(
        listener: (context, state) {
          if (state is BookingFormSubmitSuccess) {
            context.read<BookingBloc>().add(GetBookings("", "", "", ""));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Data Telah Tersimpan!"),
                duration: Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color.fromARGB(255, 99, 235, 87),
              ),
            );
            Navigator.pop(context);
          } else if (state is BookingFormSubmitFailure) {
            if (state.exception is UnauthorizedException) {
              if (state.exception is UnauthorizedException) {
                context.read<AuthenticationBloc>().add(
                  SetAuthenticationStatus(isAuthenticated: false),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Session Anda telah habis. Silakan login kembali",
                    ),
                    duration: Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xffEB5757),
                  ),
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Terjadi Error, silahkan coba beberapa saat lagi",
                ),
                duration: Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xffEB5757),
              ),
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Submit Data')));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Field
                  _buildLabel('Nama'),
                  _buildTextField(
                    controller: _namaController,
                    hintText: 'Masukkan nama lengkap',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama harus diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.w),

                  // Alamat Field
                  _buildLabel('Alamat'),
                  _buildTextField(
                    controller: _alamatController,
                    hintText: 'Masukkan alamat lengkap',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat harus diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.w),

                  // No HP & Telepon Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('No HP'),
                            _buildTextField(
                              controller: _noHpController,
                              hintText: '0812-3456-7890',
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'No HP harus diisi';
                                }
                                return null;
                              },
                              formatter: _phoneFormatter,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Telepon', required: false),
                            _buildTextField(
                              controller: _teleponController,
                              hintText: '(021) 123456',
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.w),

                  // Site, Cluster, House Item Row
                  _buildLabel('Site'),
                  BlocBuilder<SiteBloc, SiteState>(
                    builder: (context, state) {
                      return _buildDropdown<Site>(
                        label: 'Site',
                        items: state is SiteLoadedSuccess ? state.sites : [],
                        itemBuilder: (item) => item.siteName,
                        value: _selectedSite,
                        onChanged: (value) {
                          setState(() {
                            _selectedSite = value;
                            _selectedCluster = null;
                            _selectedHouseItem = null;
                          });

                          if (value == null) return;
                          context.read<ResidenceBloc>().add(
                            LoadResidence("", "", value.idSite, ""),
                          );
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Pilih site';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.w),
                  _buildLabel('Cluster'),
                  BlocBuilder<ResidenceBloc, ResidenceState>(
                    builder: (context, state) {
                      return _buildDropdown<Residence>(
                        label: 'Cluster',
                        items:
                            state is ResidenceLoadSuccess
                                ? state.residences
                                : [],
                        itemBuilder: (item) => item.clusterName,
                        value: _selectedCluster,
                        onChanged: (value) {
                          setState(() {
                            _selectedCluster = value;
                            _selectedHouseItem = null;
                          });

                          if (value == null) return;
                          context.read<HouseItemBloc>().add(
                            GetHouseItem(
                              "",
                              "",
                              _selectedSite?.idSite ?? "",
                              value.idCluster,
                              "",
                              "",
                              "",
                            ),
                          );
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Pilih cluster';
                          }
                          return null;
                        },
                      );
                    },
                  ),

                  SizedBox(height: 16.w),
                  _buildLabel('House Item'),
                  BlocBuilder<HouseItemBloc, HouseItemState>(
                    builder: (context, state) {
                      return _buildDropdown<HouseItem>(
                        label: 'House Item',
                        items:
                            state is HouseItemLoadSuccess
                                ? state.houseItems
                                : [],
                        itemBuilder: (item) => item.house_name,
                        value: _selectedHouseItem,
                        onChanged: (value) {
                          setState(() {
                            _selectedHouseItem = value;
                            _priceListController.text = NumberFormat(
                              '#,###',
                            ).format(value?.house_price ?? 0);
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Pilih house item';
                          }
                          return null;
                        },
                      );
                    },
                  ),

                  SizedBox(height: 16.w),

                  // Price List Field
                  _buildLabel('Price List'),
                  MoneyInputWidget(
                    controller: _priceListController,
                    hintText: 'Masukkan harga',
                    suffixIcon: null,
                    maxLines: 1,
                  ),
                  SizedBox(height: 16.w),

                  // Discount Field
                  _buildLabel('Discount', required: false),
                  MoneyInputWidget(
                    controller: _discountController,
                    hintText: 'Masukkan discount',
                    suffixIcon: null,
                    maxLines: 1,
                  ),
                  SizedBox(height: 16.w),

                  // Payment Term & Bank Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Payment Term'),
                            _buildDropdown<String>(
                              label: 'Payment Term',
                              items: paymentTerms,
                              itemBuilder: (item) => item,
                              value: _selectedPaymentTerm,
                              onChanged: (value) {
                                setState(() {
                                  _selectedPaymentTerm = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih payment term';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Bank'),
                            BlocBuilder<BankBloc, BankState>(
                              builder: (context, state) {
                                return _buildDropdown<Bank>(
                                  label: 'Bank',
                                  items:
                                      state is BankLoadSuccess
                                          ? state.banks
                                          : [],
                                  itemBuilder: (item) => item.bank_name,
                                  value: _selectedBank,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedBank = value;
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.w),

                  // Exp Date Field
                  _buildLabel('Exp Date(Dalam hari)'),
                  _buildTextField(
                    controller: _expDateController,
                    hintText: 'Jumlah hari sebelum expired',
                    readOnly: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Exp date harus diisi';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),

                  _buildLabel('Remark', required: false),
                  _buildTextField(
                    controller: _remarkController,
                    hintText: 'Catatan Khusus',
                    readOnly: false,
                    maxLines: 3,
                  ),
                  SizedBox(height: 24.h),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state is BookingFormLoading) return;
                        if (_formKey.currentState!.validate()) {
                          context.read<BookingFormBloc>().add(
                            SubmitBookingForm(
                              namaCustomer: _namaController.text,
                              alamatCustomer: _alamatController.text,
                              nomorHp: _noHpController.text,
                              telepon: _phoneFormatter.getUnmaskedText(),
                              houseItem: _selectedHouseItem!.id_house,
                              priceList: _priceListController.text.replaceAll(
                                ',',
                                '',
                              ),
                              discount: _discountController.text.replaceAll(
                                ',',
                                '',
                              ),
                              payterm: _selectedPaymentTerm!,
                              bank: _selectedBank!.bank_name,
                              expDate: _expDateController.text,
                              remark: _remarkController.text,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        backgroundColor: const Color(0xFF1C3FAA),
                      ),
                      child:
                          state is BookingFormLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 16.w,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
