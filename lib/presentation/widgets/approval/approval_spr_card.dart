// approval_card.dart
import 'package:fdpi_app/bloc/approval_spr/approval_spr_detail/approval_spr_detail_bloc.dart';
import 'package:fdpi_app/models/approval_spr/spr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      Text(
                        "Pengajuan SPR untuk ${widget.requests.sbkName}",
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
                            detail: state.sprDetail.wCreatedBy,
                            date: state.sprDetail.dtCreated,
                          ),
                          TimelineStep(
                            header: "Approve 1",
                            detail: state.sprDetail.wAprv1By,
                            date: state.sprDetail.dtAprv1,
                          ),
                        ],
                      ),
                      SizedBox(height: 320.w),
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
