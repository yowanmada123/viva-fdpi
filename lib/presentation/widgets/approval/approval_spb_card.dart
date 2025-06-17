// approval_card.dart
import 'package:fdpi_app/bloc/approval_spb/approval_spb_detail/approval_spb_detail_bloc.dart';
import 'package:fdpi_app/models/approval_spb/spb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'vertical_timeline.dart';

class ApprovalSpbCard extends StatefulWidget {
  final Spb requests;
  final ScrollController scrollController;
  final VoidCallback onReachBottom;
  final VoidCallback onReachTop;

  const ApprovalSpbCard({
    super.key,
    required this.requests,
    required this.scrollController,
    required this.onReachBottom,
    required this.onReachTop,
  });

  @override
  _ApprovalSpbCardState createState() => _ApprovalSpbCardState();
}

class _ApprovalSpbCardState extends State<ApprovalSpbCard> {
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
          child: BlocBuilder<ApprovalSpbDetailBloc, ApprovalSpbDetailState>(
            builder: (context, state) {
              if (state is ApprovalSpbDetailSuccess) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengajuan SPB untuk ${widget.requests.sbkName}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      Text(
                        "Site: ${widget.requests.siteName}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      Text(
                        "Cluster: ${widget.requests.clusterName}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      Text(
                        "House: ${widget.requests.houseName}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      Text(
                        "Kategori Bangunan: ${widget.requests.category}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TimelineProgress(
                        steps: [
                          TimelineStep(
                            header: "Pengajuan",
                            detail: state.spbDetail.wCreatedBy,
                          ),
                          TimelineStep(
                            header: "Approve 1",
                            detail: state.spbDetail.wAprv1By,
                          ),
                          TimelineStep(
                            header: "Approve 2",
                            detail: state.spbDetail.wAprv2By,
                          ),
                        ],
                      ),
                      SizedBox(height: 320.w),
                    ],
                  ),
                );
              }

              if (state is ApprovalSpbDetailFailure) {
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
