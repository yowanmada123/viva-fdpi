import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'spk_checklist_screen.dart';

class SpkProgressListScreen extends StatelessWidget {
  const SpkProgressListScreen({Key? key}) : super(key: key);

  static final List<Map<String, dynamic>> _sPKProgressList = [
    {"percentage": 50, "status": 'In Progress', "documentAttachment": null},
    {"percentage": 100, "status": 'Completed', "documentAttachment": null},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPK Progress', style: TextStyle(fontSize: 20.sp)),
      ),
      body: ListView.builder(
        itemCount: _sPKProgressList.length,
        itemBuilder: (context, index) {
          final spkProgress = _sPKProgressList[index];
          return ListTile(
            title: Text(
              '${spkProgress['percentage']}%',
              style: TextStyle(fontSize: 18.sp),
            ),
            subtitle: Text(
              spkProgress['status'],
              style: TextStyle(fontSize: 16.sp),
            ),
            trailing: Text(spkProgress['documentAttachment'] ?? '-'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SpkChecklistScreen();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
