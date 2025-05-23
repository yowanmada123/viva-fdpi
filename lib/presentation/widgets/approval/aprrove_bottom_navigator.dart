import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApprovalBottomBar extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onApprove;
  final bool isLoading;

  const ApprovalBottomBar({
    super.key,
    required this.onReject,
    required this.onApprove,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xffffffff),
      elevation: 8.0,
      items: [
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 16.w),
            width: double.infinity,
            child: OutlinedButton(
              onPressed: isLoading ? null : onReject,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red),
              ),
              child: Text(
                'Reject',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 16.w),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onApprove,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
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
