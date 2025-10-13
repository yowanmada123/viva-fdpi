// approval_pr_card.dart
import 'package:fdpi_app/bloc/approval_pr/approval_pr_list/approval_pr_list_bloc.dart';
import 'package:fdpi_app/models/approval_pr/approval_pr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'vertical_timeline.dart';

class ApprovalPrCard extends StatefulWidget {
  final ApprovalPR requests;
  final ScrollController scrollController;
  final VoidCallback onReachBottom;
  final VoidCallback onReachTop;

  const ApprovalPrCard({
    super.key,
    required this.requests,
    required this.scrollController,
    required this.onReachBottom,
    required this.onReachTop,
  });

  @override
  _ApprovalPrCardState createState() => _ApprovalPrCardState();
}

class _ApprovalPrCardState extends State<ApprovalPrCard> {
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
          child: BlocBuilder<ApprovalPrListBloc, ApprovalPrListState>(
            builder: (context, state) {
              if (state is ApprovalPrListLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalPrListFailureState) {
                return Center(child: Text(state.message));
              } else if (state is ApprovalPrListSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(widget.requests.office),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
                      child: Text(
                        widget.requests.typePr,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    _buildInfoRow(
                      "Departement",
                      widget.requests.deptName.isNotEmpty
                          ? widget.requests.deptName
                          : '-',
                    ),
                    _buildInfoRow("Vendor", widget.requests.vendorName),
                    // _buildInfoRow("Site", widget.requests.siteName),
                    // _buildInfoRow("Cluster", widget.requests.clusterName),
                    // _buildInfoRow("House", widget.requests.houseName),
                    _buildInfoRow("Note", widget.requests.memoTxt),
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
                                  article.amount,
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
                                          "Site: ${article.siteName}",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        Text(
                                          "Cluster: ${article.clusterName}",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                        Text(
                                          "House: ${article.houseName}",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
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

                    _buildSection(
                      "Proses Pengajuan",
                      TimelineProgress(
                        steps: [
                          TimelineStep(
                            header: "Pengajuan",
                            detail: widget.requests.wCreatedBy,
                            date: widget.requests.dtPr,
                          ),
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
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
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
