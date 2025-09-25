import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApprovalBottomBar extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onApprove;
  final bool isLoading;
  final bool canApprove;

  const ApprovalBottomBar({
    super.key,
    required this.onReject,
    required this.onApprove,
    this.isLoading = false,
    this.canApprove = false,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xffffffff),
      elevation: 8.0,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      items: [
        if (canApprove)
          BottomNavigationBarItem(
            icon: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(16.w, 8.w, 4.w, 8.w),
              child: FilledButton(
                onPressed: isLoading ? null : onReject,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Reject',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            label: '',
          ),
        if (canApprove)
          BottomNavigationBarItem(
            icon: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(4.w, 8.w, 16.w, 8.w),
              child: FilledButton(
                onPressed: isLoading ? null : onApprove,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ), // Adjust radius here
                ),
                child:
                    isLoading
                        ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(
                          'Approve',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ),
            label: '',
          ),
      ],
    );
  }
}
