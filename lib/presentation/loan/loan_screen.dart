import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/loan/loan_form/loan_form_bloc.dart';
import '../../bloc/loan/vendor_spk/vendor_spk_bloc.dart';
import '../../bloc/master/loan_type/loan_type_bloc.dart';
import '../../bloc/master/vendor/vendor_bloc.dart';
import '../../data/repository/loan_repository.dart';
import '../../data/repository/master_repository.dart';

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
                  VendorBloc(masterRepository: context.read<MasterRepository>())
                    ..add(GetVendor()),
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
      child: const LoanFormScreen(),
    );
  }
}

class LoanFormScreen extends StatefulWidget {
  const LoanFormScreen({super.key});

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
          setState(() {
            progress--;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Loan Form"),
          centerTitle: true,
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

        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Vendor"),
                    SizedBox(height: 8.w),
                    BlocBuilder<VendorBloc, VendorState>(
                      builder: (context, state) {
                        if (state is VendorLoadSuccess) {
                          return Container(
                            // Adjust as needed
                            child: SizedBox(
                              width:
                                  double.infinity, // Takes full available width
                              child: DropdownButtonFormField(
                                isExpanded:
                                    true, // Critical to prevent overflow
                                decoration: InputDecoration(
                                  border:
                                      OutlineInputBorder(), // Optional: Better visual
                                ),
                                items:
                                    state.vendors
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.vendorName,
                                              overflow: TextOverflow.ellipsis,
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
                            ),
                          );
                        }
                        return Container(
                          child: SizedBox(
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              items: [],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.w),
                    Container(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          setState(() {
                            progress++;
                          });
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
              ),
            ),
            Text("hello world 2"),
          ],
        ),
      ),
    );
  }
}
