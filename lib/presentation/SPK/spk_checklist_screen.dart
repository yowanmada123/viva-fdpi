import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewSpkChecklistScreen extends StatefulWidget {
  const NewSpkChecklistScreen({super.key});

  @override
  _NewSpkChecklistScreenState createState() => _NewSpkChecklistScreenState();
}

class _NewSpkChecklistScreenState extends State<NewSpkChecklistScreen> {
  final List<Map<String, dynamic>> _dummyData = [
    {
      'type': 'Pelunasan 30%',
      'isExpanded': true,
      'data': [
        {
          'category': 'Tanah Rata',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
        {
          'category': 'Air Tanah',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
        {
          'category': 'Kategori 3',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
      ],
    },
    {
      'type': 'Pelunasan 60%',
      'isExpanded': true,
      'data': [
        {
          'category': 'Tanah Rata',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
        {
          'category': 'Air Tanah',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
        {
          'category': 'Kategori 3',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
      ],
    },
    {
      'type': 'Pelunasan 90%',
      'isExpanded': true,
      'data': [
        {
          'category': 'Tanah Rata',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
        {
          'category': 'Air Tanah',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
        {
          'category': 'Kategori 3',
          'isDone': false,
          'data': [
            {'qc_item': 'Tanah Rata', 'isDone': null, 'qcApproval': null},
            {'qc_item': 'Pkau Bumi', 'isDone': null, 'qcApproval': null},
          ],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPK Checklist')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Single ExpansionPanelList containing all panels
              ExpansionPanelList(
                expandIconColor: Colors.white,
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    _dummyData[panelIndex]['isExpanded'] = isExpanded;
                  });
                },
                expandedHeaderPadding: EdgeInsets.all(0),
                children:
                    _dummyData.map<ExpansionPanel>((item) {
                      return ExpansionPanel(
                        backgroundColor: const Color(0xff1f1f1f),
                        isExpanded: item['isExpanded'],
                        canTapOnHeader: true,
                        headerBuilder:
                            (context, isExpanded) => Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: const BoxDecoration(
                                color: Color(0xff1f1f1f),
                              ),
                              child: Text(
                                item['type'],
                                style: TextStyle(
                                  fontSize: max(16.sp, 16.0),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        body: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Color(0xff1f1f1f),
                              ),
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Details for ${item['type']}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 32.w,
                                    child: Center(
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 32.w,
                                    child: Center(
                                      child: Text(
                                        "QC",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
