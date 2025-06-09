import 'package:fdpi_app/bloc/QC/vendor_has_spk/vendor_has_spk_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/loan/loan_form/loan_form_bloc.dart';
import '../../bloc/loan/vendor_spk/vendor_spk_bloc.dart';
import '../../bloc/master/loan_type/loan_type_bloc.dart';
import '../../data/repository/loan_repository.dart';
import '../../data/repository/master_repository.dart';
import '../../data/repository/spk_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../widgets/MoneyInputWidget.dart';

class LoanScreen extends StatelessWidget {
  final String title;
  const LoanScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  VendorHasSpkBloc(spkRepository: context.read<SPKRepository>())
                    ..add(GetVendorHasSpkEvent()),
        ),
        BlocProvider(
          create:
              (_) => LoanTypeBloc(
                masterRepository: context.read<MasterRepository>(),
              )..add(GetLoanTypeEvent()),
        ),
        BlocProvider(
          create:
              (_) =>
                  LoanFormBloc(loanRepository: context.read<LoanRepository>()),
        ),
        BlocProvider(
          create:
              (_) =>
                  VendorSpkBloc(loanRepository: context.read<LoanRepository>()),
        ),
      ],
      child: LoanFormScreen(title: title),
    );
  }
}

class LoanFormScreen extends StatefulWidget {
  final String title;
  const LoanFormScreen({super.key, required this.title});

  @override
  State<LoanFormScreen> createState() => _LoanFormScreenState();
}

class _LoanFormScreenState extends State<LoanFormScreen> {
  double progress = 1;
  final pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pageController.page != 0) {
          pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
          return false;
        }
        return true;
      },
      child: SafeArea(
        maintainBottomViewPadding: true,
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(5),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1C3FAA),
                      Color(0xffA4C8FF),
                      Colors.grey.shade300,
                      Colors.grey.shade300,
                    ],
                    stops: [0, progress / 2, progress / 2, 1],
                  ),
                ),
                child: const SizedBox(height: 5),
              ),
            ),
          ),

          body: BlocConsumer<LoanFormBloc, LoanFormState>(
            listener: (context, state) {
              if (state.status == FormStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Data Kasbon telah disimpan"),
                    duration: Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 28, 170, 52),
                  ),
                );
                context.read<LoanFormBloc>().add(FormReset());
                context.read<VendorSpkBloc>().add(VendorSpkResetEvent());
                pageController.jumpToPage(0);
                return;
              }

              if (state.status == FormStatus.failure) {
                if (state.exception is UnauthorizedException) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Session anda telah habis. Silakan login kembali",
                      ),
                      duration: Duration(seconds: 3),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color.fromARGB(255, 243, 78, 78),
                    ),
                  );
                  context.read<AuthenticationBloc>().add(
                    SetAuthenticationStatus(isAuthenticated: false),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Telah terjadi kesalahan. Silakan coba lagi!",
                    ),
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color.fromARGB(255, 243, 78, 78),
                  ),
                );
                return;
              }
            },
            builder: (context, state) {
              return PageView(
                controller: pageController,
                onPageChanged: (value) => setState(() => progress = value + 1),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: BlocBuilder<LoanFormBloc, LoanFormState>(
                      builder: (context, loanFormState) {
                        return Container(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Vendor"),
                              SizedBox(height: 8.w),
                              BlocBuilder<VendorHasSpkBloc, VendorHasSpkState>(
                                builder: (context, state) {
                                  if (state is VendorHasSpkLoadedSuccess) {
                                    return SizedBox(
                                      width: double.infinity,
                                      child: DropdownButtonFormField(
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          fillColor: const Color(0xffffffff),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 0,
                                          ),
                                        ),
                                        value: loanFormState.selectedVendor,
                                        items:
                                            state.vendors
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.vendorName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                      ), // Adjust font size if needed
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                        onChanged: (value) {
                                          context.read<VendorSpkBloc>().add(
                                            VendorSpkLoadEvent(
                                              vendorId: value!.vendorId,
                                            ),
                                          );
                                          context.read<LoanFormBloc>().add(
                                            VendorChanged(value),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return SizedBox(
                                    width: double.infinity,
                                    child: DropdownButtonFormField(
                                      items: [],
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        fillColor: const Color(0xffffffff),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 0,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 16.w),
                              Text("SPK Vendor"),
                              SizedBox(height: 8.w),
                              BlocBuilder<VendorSpkBloc, VendorSpkState>(
                                builder: (context, state) {
                                  if (state is VendorSpkLoadSuccess) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6 -
                                          42.w,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        itemCount: state.vendorSpks.length,
                                        itemBuilder: (context, index) {
                                          return CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            tileColor:
                                                (index % 2 == 0
                                                    ? Colors.white
                                                    : Colors.grey.shade200),
                                            title: Text(
                                              state.vendorSpks[index].idCetak,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            subtitle: Text(
                                              "${state.vendorSpks[index].siteName} - ${state.vendorSpks[index].clusterName} - ${state.vendorSpks[index].houseName}",
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            value:
                                                loanFormState.selectedSpk ==
                                                state.vendorSpks[index],
                                            onChanged: (bool? value) {
                                              if (value == null || !value) {
                                                context
                                                    .read<LoanFormBloc>()
                                                    .add(
                                                      SpkVendorChanged(null),
                                                    );
                                                return;
                                              }
                                              context.read<LoanFormBloc>().add(
                                                SpkVendorChanged(
                                                  state.vendorSpks[index],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.6 -
                                        42.w,
                                    padding: EdgeInsets.all(16.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                      "Harap pilih terlebih dahulu vendor",
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 24.w),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Color(0xff1C3FAA),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ), // Adjust radius here
                                  ),
                                  onPressed: () {
                                    if (loanFormState.selectedSpk == null ||
                                        loanFormState.selectedVendor == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Pilih Vendor dan SPK terlebih dahulu",
                                          ),
                                          duration: Duration(seconds: 2),
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          backgroundColor: Color(0xffff0000),
                                        ),
                                      );
                                      return;
                                    }
                                    pageController.nextPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.linear,
                                    );
                                  },
                                  child: Text("Next"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  _LoanFormSecondStep(
                    onBackFunction: () {
                      pageController.previousPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LoanFormSecondStep extends StatefulWidget {
  final Function onBackFunction;
  const _LoanFormSecondStep({required this.onBackFunction});

  @override
  State<_LoanFormSecondStep> createState() => _LoanFormSecondStepState();
}

class _LoanFormSecondStepState extends State<_LoanFormSecondStep> {
  final _kasbonController = TextEditingController();

  @override
  void dispose() {
    _kasbonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<LoanFormBloc, LoanFormState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Vendor"),
                    SizedBox(height: 8.w),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                      readOnly: true,
                      initialValue:
                          state.selectedVendor == null
                              ? ""
                              : state.selectedVendor!.vendorName,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SPK Vendor"),
                    SizedBox(height: 8.w),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                      readOnly: true,
                      initialValue:
                          state.selectedSpk == null
                              ? ""
                              : state.selectedSpk!.idCetak,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Site"),
                    SizedBox(height: 8.w),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                      readOnly: true,
                      initialValue:
                          state.selectedSpk == null
                              ? ""
                              : state.selectedSpk!.siteName,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Cluster"),
                    SizedBox(height: 8.w),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                      readOnly: true,
                      initialValue:
                          state.selectedSpk == null
                              ? ""
                              : state.selectedSpk!.clusterName,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("House Item"),
                    SizedBox(height: 8.w),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                      readOnly: true,
                      initialValue:
                          state.selectedSpk == null
                              ? ""
                              : state.selectedSpk!.houseName,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tipe Kasbon"),
                    SizedBox(height: 8.w),
                    BlocBuilder<LoanTypeBloc, LoanTypeState>(
                      builder: (context, loanState) {
                        if (loanState is LoanTypeLoadSuccess) {
                          return SizedBox(
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                fillColor: const Color(0xffffffff),
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 0,
                                ),
                              ),
                              value: state.selectedLoanType,
                              items:
                                  loanState.loanTypes
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e.str2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ), // Adjust font size if needed
                                          ),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                if (value == null) return;
                                context.read<LoanFormBloc>().add(
                                  LoanTypeChanged(value),
                                );
                              },
                            ),
                          );
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: DropdownButtonFormField(
                            items: [],
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              fillColor: const Color(0xffffffff),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nominal Kasbon"),
                    SizedBox(height: 8.w),
                    MoneyInputWidget(
                      controller: _kasbonController,
                      suffixIcon: null,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tanggal Transaksi Kasbon"),
                    SizedBox(height: 8.w),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        prefixIcon: const Icon(Icons.calendar_today),
                        prefixIconColor: const Color(0xff333333),
                      ),
                      readOnly: true,
                      onTap:
                          () => context.read<LoanFormBloc>().add(
                            DateSelectionRequested(context),
                          ),
                      controller: TextEditingController(
                        text: state.dateLoanFormatted,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Remark"),
                    SizedBox(height: 8.w),
                    TextFormField(
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        fillColor: const Color(0xffffffff),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        context.read<LoanFormBloc>().add(RemarkChanged(value));
                      },
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xffff0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ), // Adjust radius here
                        ),
                        onPressed: () {
                          widget.onBackFunction();
                        },
                        child: Text("Back"),
                      ),
                    ),
                    SizedBox(width: 24.w),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xff1C3FAA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ), // Adjust radius here
                        ),
                        onPressed: () {
                          context.read<LoanFormBloc>().add(
                            LoanFormSubmit(amount: _kasbonController.text),
                          );
                        },
                        child: Text("Submit"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
