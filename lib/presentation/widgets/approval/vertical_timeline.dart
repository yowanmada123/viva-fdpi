import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TimelineStatus { waiting, approved, rejected }

class TimelineProgress extends StatelessWidget {
  final List<TimelineStep> steps;
  final Map<TimelineStatus, Color> colors;

  const TimelineProgress({
    super.key,
    required this.steps,
    this.colors = const {
      TimelineStatus.approved: Color(0xff27AE60),
      TimelineStatus.rejected: Color(0xffEB5757),
      TimelineStatus.waiting: Color(0xffF2C94C),
    },
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        final isLast = index == steps.length - 1;
        final step = steps[index];

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Timeline column (bullet + connector)
              Column(
                children: [
                  // Bullet point
                  SizedBox(height: 6.w),
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          step.status == null
                              ? Colors.grey
                              : colors[step.status],
                    ),
                  ),
                  // Connector (except for last item)
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color:
                            step.status == null
                                ? Colors.grey
                                : colors[step.status],
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12),
              // Content column
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Header
                      Text(
                        step.header,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      // Detail
                      Text(
                        step.detail,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                      // Additional content can be added here
                      if (step.additionalContent != null) ...[
                        SizedBox(height: 8),
                        step.additionalContent!,
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class TimelineStep {
  final String header;
  final String detail;
  final TimelineStatus? status;
  final Widget? additionalContent;
  final IconData? icon;

  TimelineStep({
    required this.header,
    required this.detail,
    this.status,
    this.additionalContent,
    this.icon,
  });
}
