// approval_card.dart
import 'dart:developer';

import 'package:fdpi_app/bloc/approval_spr/approval_spr_detail/approval_spr_detail_bloc.dart';
import 'package:fdpi_app/models/approval_spr/spr.dart';
import 'package:fdpi_app/utils/datetime_convertion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'vertical_timeline.dart';

class ApprovalSprCard extends StatefulWidget {
  final Spr requests;
  final ScrollController scrollController;
  final VoidCallback onReachBottom;
  final VoidCallback onReachTop;

  const ApprovalSprCard({
    super.key,
    required this.requests,
    required this.scrollController,
    required this.onReachBottom,
    required this.onReachTop,
  });

  @override
  _ApprovalSprCardState createState() => _ApprovalSprCardState();
}

class _ApprovalSprCardState extends State<ApprovalSprCard> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final position = widget.scrollController.position;
    if (position.pixels >= position.maxScrollExtent) {
      widget.onReachBottom();
    }
    if (position.pixels <= position.minScrollExtent) {
      widget.onReachTop();
    }
  }

  String formatRupiah(num number) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format(number);
  }

  Widget _infoItem(String label, String? value) {
    final displayValue =
        (value == null || value.trim().isEmpty) ? '' : value.trim();

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("ApprovalSprCard build: ${widget.requests.idSpr}");
    return SingleChildScrollView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: BlocBuilder<ApprovalSprDetailBloc, ApprovalSprDetailState>(
            builder: (context, state) {
              if (state is ApprovalSprDetailSuccess) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Pengajuan SPR",
                      //   style: TextStyle(
                      //     fontSize: 18.sp,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      SizedBox(height: 6.h),

                      Text(
                        widget.requests.sbkName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color.fromARGB(255, 7, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20.h),

                      _infoItem("Site", widget.requests.siteName),
                      _infoItem("Cluster", widget.requests.clusterName),
                      _infoItem("Kategori", widget.requests.category),

                      _infoItem("Tipe", widget.requests.commonName),
                      _infoItem("House Number", widget.requests.houseName),
                      _infoItem("Customer", widget.requests.namaCustomer),
                      _infoItem(
                        "Order Date",
                        formatDateTime(widget.requests.orderDate),
                      ),
                      _infoItem(
                        "Order Amount",
                        formatRupiah(double.parse(widget.requests.orderAmt)),
                      ),
                      _infoItem("Pay Term", widget.requests.payMethod),
                      _infoItem("Sales", widget.requests.namaSales),
                      _infoItem("Remark", widget.requests.remark),

                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                "Progress Approval: ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      TimelineProgress(
                        steps: [
                          TimelineStep(
                            header: "Pengajuan",
                            detail: widget.requests.wCreatedBy,
                            date: stringToDateTime(widget.requests.orderDate),
                          ),
                          TimelineStep(
                            header: "Approve 1",
                            detail: widget.requests.wAprv1By,
                            date: stringToDateTime(widget.requests.dtAprv1),
                          ),
                        ],
                      ),

                      SizedBox(height: 400.w),
                    ],
                  ),
                );
              }

              if (state is ApprovalSprDetailFailure) {
                return Center(child: Text(state.message));
              }

              return Container(
                padding: EdgeInsets.all(16.w),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}
