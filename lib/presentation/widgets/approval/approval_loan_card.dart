// approval_card.dart
import 'package:fdpi_app/bloc/approval_loan/approval_loan_list/approval_loan_list_bloc.dart';
import 'package:fdpi_app/models/approval_loan/approval_loan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../utils/currency_format.dart';
import 'vertical_timeline.dart';

class ApprovalCard extends StatefulWidget {
  final ApprovalLoan requests;
  final ScrollController scrollController;
  final VoidCallback onReachBottom;
  final VoidCallback onReachTop;

  const ApprovalCard({
    super.key,
    required this.requests,
    required this.scrollController,
    required this.onReachBottom,
    required this.onReachTop,
  });

  @override
  _ApprovalCardState createState() => _ApprovalCardState();
}

class _ApprovalCardState extends State<ApprovalCard> {
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
          child: BlocBuilder<ApprovalLoanListBloc, ApprovalLoanListState>(
            builder: (context, state) {
              if (state is ApprovalLoanListLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalLoanListLoadFailure) {
                return Center(child: Text(state.message));
              } else if (state is ApprovalLoanListLoadSuccess) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle(widget.requests.office),
                    _buildInfoRow("No Kasbon", widget.requests.trId),
                    _buildInfoRow(
                      "Tanggal Pengajuan",
                      widget.requests.dtKb != null
                          ? DateFormat(
                            "d MMMM yyyy",
                            'id_ID',
                          ).format(widget.requests.dtKb!)
                          : "-",
                    ),
                    _buildInfoRow("Diajukan oleh", widget.requests.vendorName),
                    _buildInfoRow("Tipe SPK", widget.requests.wSpkType),
                    _buildInfoRow("Site", widget.requests.siteName),
                    _buildInfoRow("Cluster", widget.requests.clusterName),
                    _buildInfoRow("House", widget.requests.houseName),
                    _buildInfoRow(
                      "Nilai Kontrak",
                      formatIDRCurrency(widget.requests.amt),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoRow(
                            "Nominal KasBon",
                            formatIDRCurrency(widget.requests.kbAmt),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: _buildInfoRow(
                            "Credit Limit",
                            formatIDRCurrency(widget.requests.creditLimit),
                          ),
                        ),
                      ],
                    ),
                    _buildInfoRow("Remark", widget.requests.remark),
                    _buildSection(
                      "Proses Pengajuan",
                      TimelineProgress(
                        steps: [
                          TimelineStep(
                            header: "Pengajuan",
                            detail: widget.requests.wCreatedBy,
                            date: widget.requests.dtKb,
                          ),
                          TimelineStep(
                            header: "Approve 1",
                            detail: widget.requests.wAprv1By,
                            date: widget.requests.dtAprv1,
                          ),
                          TimelineStep(
                            header: "Approve 2",
                            detail: widget.requests.wAprv2By,
                            date: widget.requests.dtAprv2,
                          ),
                          TimelineStep(
                            header: "Approve 3",
                            detail: widget.requests.wAprv3By,
                            date: widget.requests.dtAprv3,
                          ),
                          TimelineStep(
                            header: "Approve 4",
                            detail: widget.requests.wAprv4By,
                            date: widget.requests.dtAprv4,
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
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.w),
          Text(value),
          SizedBox(height: 16.w),
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
