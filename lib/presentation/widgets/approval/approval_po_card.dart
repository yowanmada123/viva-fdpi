// approval_card.dart
import 'package:fdpi_app/bloc/approval_po/approval_po_list/approval_po_list_bloc.dart';
import 'package:fdpi_app/models/approval_po/approval_po.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'vertical_timeline.dart';

class ApprovalPoCard extends StatefulWidget {
  final ApprovalPo requests;
  final ScrollController scrollController;
  final VoidCallback onReachBottom;
  final VoidCallback onReachTop;

  const ApprovalPoCard({
    super.key,
    required this.requests,
    required this.scrollController,
    required this.onReachBottom,
    required this.onReachTop,
  });

  @override
  _ApprovalPoCardState createState() => _ApprovalPoCardState();
}

class _ApprovalPoCardState extends State<ApprovalPoCard> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final position = widget.scrollController.position;
    if (position.pixels >= position.maxScrollExtent * 1.00) {
      widget.onReachBottom();
    }
    if (position.pixels <= position.minScrollExtent * 1.00) {
      widget.onReachTop();
    }
  }

  String formatCurrency(dynamic amount) {
    final number = double.tryParse(amount.toString()) ?? 0;
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return formatter.format(number);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: BlocBuilder<ApprovalPoListBloc, ApprovalPoListState>(
            builder: (context, state) {
              if (state is ApprovalPoListLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalPoListFailureState) {
                return Center(child: Text(state.messsage));
              } else if (state is ApprovalPoListSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(widget.requests.office),
                    _buildInfoRow(
                      "Tanggal Pengajuan",
                      widget.requests.dtPo!.toLocal().toString(),
                    ),
                    _buildInfoRow(
                      "Diajukan oleh",
                      widget.requests.vendorName.isNotEmpty
                          ? widget.requests.vendorName
                          : '-',
                    ),
                    _buildInfoRow(
                      "Departement",
                      widget.requests.deptName.isNotEmpty
                          ? widget.requests.deptName
                          : '-',
                    ),
                    _buildInfoRow(
                      "Jumlah",
                      double.tryParse(
                            widget.requests.qty,
                          )?.toStringAsFixed(0) ??
                          '0',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            "Subtotal",
                            formatCurrency(widget.requests.amtSubtotal),
                          ),
                        ),
                        Expanded(
                          child: _buildInfoRow(
                            "PPN",
                            formatCurrency(widget.requests.amtPpn),
                          ),
                        ),
                      ],
                    ),
                    _buildInfoRow(
                      "Total",
                      formatCurrency(widget.requests.amtNet),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.w,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Article",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.w),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.requests.article.length,
                              itemBuilder: (context, index) {
                                final article = widget.requests.article[index];
                                final String description = article.description;
                                final String unitPrice = formatCurrency(
                                  article.unitPrice,
                                );
                                final String qty = article.qty;
                                final String price = formatCurrency(
                                  article.amtNet,
                                );

                                return Card(
                                  elevation: 2,
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.surfaceBright,
                                  margin: EdgeInsets.symmetric(vertical: 4.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          description,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4.w),
                                        Text(
                                          "Quantity: $qty",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        Text(
                                          "Unit price: $unitPrice",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        Text(
                                          "Amount: $price",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildInfoRow(
                      "Remark",
                      widget.requests.memoTxt.isNotEmpty
                          ? widget.requests.memoTxt
                          : '-',
                    ),
                    _buildSection(
                      "Proses Pengajuan",
                      TimelineProgress(
                        steps: [
                          // TimelineStep(
                          //   header: "Pengajuan",
                          //   detail: widget.requests.wCreatedBy,
                          // ),
                          TimelineStep(
                            header: "Approve 1",
                            detail: widget.requests.wAprv1By,
                            date: widget.requests.dtAprv,
                          ),
                          TimelineStep(
                            header: "Approve 2",
                            detail: widget.requests.wAprv2By,
                            date: widget.requests.dtAprv2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.w),
                  ],
                );
              }
              return Center(child: Text("No data available"));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.w),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.w),
          content,
          SizedBox(height: 16.w),
        ],
      ),
    );
  }
}
