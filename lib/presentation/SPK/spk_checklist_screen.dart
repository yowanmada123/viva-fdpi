import 'dart:io';
import 'dart:math';

import 'package:fdpi_app/presentation/widgets/spk/spk_category.dart';
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
            {
              'qc_item': 'Wkagfhlha wkoghagja wahghlasj',
              'isDone': null,
              'qcApproval': null,
            },
          ],
        },
        {
          'category': 'Wkagfhlha wkoghagja wahghlasj',
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
                            ...item['data']
                                .asMap()
                                .entries
                                .map<Widget>(
                                  (category) => SpkChecklistAccordion(
                                    index: category.key,
                                    showCheckboxQC: false,
                                    showCheckboxApplicator: false,
                                    initiallyExpanded: true,
                                    backgroundColor: const Color(0xFFCFE2FF),
                                    title: category.value['category'],
                                    content: Container(
                                      child: Column(
                                        children: [
                                          ...category.value['data']
                                              .asMap()
                                              .entries
                                              .map(
                                                (
                                                  qcItem,
                                                ) => SpkChecklistAccordion(
                                                  index: qcItem.key,
                                                  showCheckboxQC: true,
                                                  showCheckboxApplicator: true,
                                                  showCheckboxInspector: true,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 8.w,
                                                  ),
                                                  showIcon: false,
                                                  titleStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12.sp,
                                                  ),
                                                  title:
                                                      qcItem.value['qc_item'],
                                                  content: Container(
                                                    width: double.infinity,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Remark",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.w),
                                                        Text(
                                                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                                          maxLines: 2,
                                                          overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                        ),
                                                        SizedBox(height: 8.w),

                                                        Text(
                                                          "Attachment",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.w),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              ...List.generate(
                                                                Random().nextInt(
                                                                      6,
                                                                    ) +
                                                                    1,
                                                                (
                                                                  index,
                                                                ) => Padding(
                                                                  padding:
                                                                      EdgeInsets.only(
                                                                        right:
                                                                            4.w,
                                                                      ),
                                                                  child: SizedBox(
                                                                    width: 64.w,
                                                                    height:
                                                                        64.w,
                                                                    child: Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              2,
                                                                            ),
                                                                        color:
                                                                            Colors.grey[300],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () async {
                                                                  FilePickerResult?
                                                                  result = await FilePicker
                                                                      .platform
                                                                      .pickFiles(
                                                                        allowMultiple:
                                                                            true,
                                                                      );

                                                                  if (result !=
                                                                      null) {
                                                                    List<File>
                                                                    files =
                                                                        result
                                                                            .paths
                                                                            .map(
                                                                              (
                                                                                path,
                                                                              ) => File(
                                                                                path!,
                                                                              ),
                                                                            )
                                                                            .toList();
                                                                  } else {
                                                                    // User canceled the picker
                                                                  }
                                                                },
                                                                child: SizedBox(
                                                                  width: 64.w,
                                                                  height: 64.w,
                                                                  child: Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                        color: Color(
                                                                          0xffE2E2E2,
                                                                        ),
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            2,
                                                                          ),
                                                                      color: Color(
                                                                        0xffF9F9F9,
                                                                      ),
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .upload,
                                                                          color: Color(
                                                                            0xff555555,
                                                                          ),
                                                                          size:
                                                                              16.w,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4.w,
                                                                        ),
                                                                        Text(
                                                                          "Upload",
                                                                          style: TextStyle(
                                                                            color: Color(
                                                                              0xff555555,
                                                                            ),
                                                                            fontSize:
                                                                                10.sp,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
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
