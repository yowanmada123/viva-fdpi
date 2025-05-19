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
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    _dummyData[panelIndex]['isExpanded'] = isExpanded;
                  });
                },
                expandedHeaderPadding: EdgeInsets.all(0),
                children:
                    _dummyData.map<ExpansionPanel>((item) {
                      return ExpansionPanel(
                        backgroundColor: Color(0xff1F1F1F),
                        headerBuilder:
                            (context, isExpanded) => Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Text(
                                item['type'],
                                style: TextStyle(
                                  fontSize: max(16.sp, 16.0),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        body: Container(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            children: [
                              // Example nested content
                              Text("Details for ${item['type']}"),
                              // You can add another ExpansionPanelList here for categories
                              // if you need nested expansion panels
                            ],
                          ),
                        ),
                        isExpanded: item['isExpanded'],
                        canTapOnHeader: true,
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
