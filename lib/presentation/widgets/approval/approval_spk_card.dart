// approval_card.dart
import 'package:fdpi_app/models/approval_spk/approval_spk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'vertical_timeline.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ApprovalSpkCard extends StatefulWidget {
  final ApprovalSpk requests;
  final ScrollController scrollController;
  final VoidCallback onReachBottom;
  final VoidCallback onReachTop;

  const ApprovalSpkCard({
    super.key,
    required this.requests,
    required this.scrollController,
    required this.onReachBottom,
    required this.onReachTop,
  });

  @override
  _ApprovalSpkCardState createState() => _ApprovalSpkCardState();
}

class _ApprovalSpkCardState extends State<ApprovalSpkCard> {
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
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pengajuan SPK untuk ${widget.requests.sbkName}",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.w),
              Text(
                "ID SPK: ${widget.requests.idSpk}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.w),
              Text(
                "Site: ${widget.requests.siteName}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.w),
              Text(
                "Cluster: ${widget.requests.clusterName}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.w),
              Text(
                "House: ${widget.requests.houseName}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.w),
              Text(
                "Remark QC",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.w),
              HtmlWidget(
                widget.requests.remarkQc,
                textStyle: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 16.w),
              Text(
                "Remark Approval",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.w),
              HtmlWidget(
                widget.requests.remarks,
                textStyle: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 16.w),
              Text(
                "Timeline",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.w),
              TimelineProgress(
                steps: [
                  TimelineStep(
                    header: "Pengajuan",
                    detail: widget.requests.wCreatedBy,
                  ),
                  TimelineStep(
                    header: "Approve 1",
                    detail: widget.requests.wAprv1By,
                  ),
                  TimelineStep(
                    header: "Approve 2",
                    detail: widget.requests.wAprv2By,
                  ),
                ],
              ),
              SizedBox(height: 320.w),
            ],
          ),
        ),
      ),
    );
  }
}
