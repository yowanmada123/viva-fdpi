import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fdpi_app/bloc/QC/approve_detail/approve_detail_bloc.dart';
import 'package:fdpi_app/bloc/QC/checklist/checklist_bloc.dart';
import 'package:fdpi_app/bloc/QC/spk_checklist/spk_checklist_bloc.dart';
import 'package:fdpi_app/presentation/widgets/qc_checklist/spk_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/QC/approve_checklist/approve_checklist_bloc.dart';
import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../data/repository/spk_repository.dart';
import '../../models/attachment.dart';
import '../../models/errors/custom_exception.dart';

class NewSpkChecklistScreen extends StatelessWidget {
  final String qcTransId;
  const NewSpkChecklistScreen({super.key, required this.qcTransId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  SpkChecklistBloc(spkRepository: context.read<SPKRepository>())
                    ..add(LoadSpkChecklist(qcTransId: qcTransId)),
        ),
        BlocProvider(
          create:
              (context) => ApproveChecklistBloc(
                spkRepository: context.read<SPKRepository>(),
              ),
        ),
        BlocProvider(
          create:
              (context) => ApproveDetailBloc(
                spkRepository: context.read<SPKRepository>(),
              ),
        ),
      ],
      child: SpkChecklistForm(qcTransId: qcTransId),
    );
  }
}

class SpkChecklistForm extends StatefulWidget {
  final String qcTransId;
  const SpkChecklistForm({super.key, required this.qcTransId});

  @override
  SpkChecklistFormState createState() => SpkChecklistFormState();
}

class SpkChecklistFormState extends State<SpkChecklistForm> {
  final colorExpandedBox = [
    Colors.red,
    Colors.orange,
    Colors.teal,
    Colors.green,
  ];

  void checkboxEvent(
    int param,
    String id,
    BuildContext context,
    String remark,
    List<Attachment>? fileImage, {
    bool? value,
  }) {
    context.read<ApproveChecklistBloc>().add(
      ApproveChecklistEventInit(
        qcTransId: widget.qcTransId,
        idQcItem: id,
        idWork: param.toString(),
        remark: remark,
        fileImage: fileImage,
      ),
    );
  }

  void unapproveChecklist(int param, String id, BuildContext context) {
    context.read<ApproveChecklistBloc>().add(
      ApproveChecklistCancel(
        qcTransId: widget.qcTransId,
        idQcItem: id,
        idWork: param.toString(),
      ),
    );
  }

  void updateChecklist(
    int param,
    String id,
    BuildContext context,
    String remark,
    List<Attachment>? fileImage,
    List<String> deleteImage,
  ) {
    context.read<ApproveChecklistBloc>().add(
      ApproveChecklistUpdate(
        qcTransId: widget.qcTransId,
        idQcItem: id,
        idWork: param.toString(),
        remark: remark,
        fileImage: fileImage,
        deleteImage: deleteImage,
      ),
    );
  }

  Future<void> loadApproveDetail(int idWork, String idQcItem) async {
    context.read<ApproveDetailBloc>().add(
      LoadApproveDetail(
        qcTransId: widget.qcTransId,
        idQcItem: idQcItem,
        idWork: idWork.toString(),
      ),
    );
  }

  final List<bool> _expandedStatus = List.generate(10, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPK Checklist')),
      body: BlocListener<ApproveChecklistBloc, ApproveChecklistState>(
        listener: (context, state) {
          if (state is ApproveChecklistLoadSuccess) {
            context.read<SpkChecklistBloc>().add(
              LoadSpkChecklist(qcTransId: widget.qcTransId),
            );
          }
          if (state is ApproveChecklistLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Color(0xffEB5757),
              ),
            );
          }
        },
        child: BlocConsumer<SpkChecklistBloc, SpkChecklistState>(
          listener: (context, state) {
            if (state is SpkChecklistLoadFailure) {
              if (state.error is UnauthorizedException) {
                context.read<AuthenticationBloc>().add(
                  SetAuthenticationStatus(isAuthenticated: false),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Session Anda telah habis. Silakan login kembali",
                    ),
                    duration: Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xffEB5757),
                  ),
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }
            if (state is ChecklistLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Loading..."),
                  duration: Duration(seconds: 5),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                  backgroundColor: Color.fromARGB(255, 80, 80, 80),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SpkChecklistLoadSuccess) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionPanelList(
                        expandIconColor: Colors.white,
                        expansionCallback: (panelIndex, isExpanded) {
                          setState(() {
                            _expandedStatus[panelIndex] = isExpanded;
                          });
                        },
                        expandedHeaderPadding: EdgeInsets.all(0),
                        children:
                            state.checklistItem.asMap().entries.map<
                              ExpansionPanel
                            >((item) {
                              return ExpansionPanel(
                                backgroundColor: colorExpandedBox[item.key % 4],
                                isExpanded: _expandedStatus[item.key],
                                canTapOnHeader: true,
                                headerBuilder:
                                    (context, isExpanded) => Container(
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                        color: colorExpandedBox[item.key % 4],
                                      ),
                                      child: Text(
                                        item.value.comDesc,
                                        style: TextStyle(
                                          fontSize: max(16.sp, 16.0),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                body: Column(
                                  children: [
                                    ...item.value.checklistCategories.asMap().entries.map<
                                      Widget
                                    >(
                                      (category) => SpkChecklistAccordion(
                                        index: category.key,
                                        showCheckboxQC: false,
                                        showCheckboxApplicator: false,
                                        initiallyExpanded: true,
                                        title: category.value.catName,
                                        content: Container(
                                          child: Column(
                                            children: [
                                              ...category.value.checklistItems.asMap().entries.map(
                                                (
                                                  qcItem,
                                                ) => SpkChecklistAccordion(
                                                  index: qcItem.key,
                                                  showCheckboxQC: true,
                                                  showCheckboxApplicator: true,
                                                  showCheckboxInspector: true,
                                                  showIcon: false,
                                                  onApproveDetail: (idWork) {
                                                    loadApproveDetail(
                                                      idWork,
                                                      qcItem.value.idQcItem,
                                                    );
                                                  },
                                                  onUnapproveChecklist: (
                                                    idWork,
                                                  ) {
                                                    if (idWork == 1 &&
                                                        (qcItem.value.dtAprv2 !=
                                                                null ||
                                                            qcItem
                                                                    .value
                                                                    .dtAprv3 !=
                                                                null)) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "Anda tidak bisa unapprove checklist ini",
                                                          ),
                                                          duration: Duration(
                                                            seconds: 5,
                                                          ),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4.w,
                                                                ),
                                                          ),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                255,
                                                                80,
                                                                80,
                                                                80,
                                                              ),
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    if (idWork == 2 &&
                                                        qcItem.value.dtAprv3 !=
                                                            null) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "Anda tidak bisa unapprove checklist ini",
                                                          ),
                                                          duration: Duration(
                                                            seconds: 5,
                                                          ),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4.w,
                                                                ),
                                                          ),
                                                          backgroundColor:
                                                              Color.fromARGB(
                                                                255,
                                                                80,
                                                                80,
                                                                80,
                                                              ),
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    unapproveChecklist(
                                                      idWork,
                                                      qcItem.value.idQcItem,
                                                      context,
                                                    );
                                                  },
                                                  onUpdateChecklist: (
                                                    idWork,
                                                    remark,
                                                    fileImage,
                                                    deleteImage,
                                                  ) {
                                                    updateChecklist(
                                                      idWork,
                                                      qcItem.value.idQcItem,
                                                      context,
                                                      remark,
                                                      fileImage,
                                                      deleteImage,
                                                    );
                                                  },
                                                  onCheckboxApplicatorChanged:
                                                      qcItem.value.statClosing ==
                                                              'N'
                                                          ? (
                                                            value,
                                                            remark,
                                                            fileImage,
                                                          ) {
                                                            checkboxEvent(
                                                              1,
                                                              qcItem
                                                                  .value
                                                                  .idQcItem,
                                                              context,
                                                              value: value,
                                                              remark,
                                                              fileImage,
                                                            );
                                                          }
                                                          : null,
                                                  onCheckboxInspectorChanged:
                                                      qcItem.value.statClosing2 ==
                                                                  'N' &&
                                                              qcItem
                                                                      .value
                                                                      .dtAprv !=
                                                                  null
                                                          ? (
                                                            value,
                                                            remark,
                                                            fileImage,
                                                          ) {
                                                            checkboxEvent(
                                                              2,
                                                              qcItem
                                                                  .value
                                                                  .idQcItem,
                                                              context,
                                                              value: value,
                                                              remark,
                                                              fileImage,
                                                            );
                                                          }
                                                          : null,
                                                  onCheckboxQCChanged:
                                                      qcItem.value.statClosing3 ==
                                                                  'N' &&
                                                              qcItem
                                                                      .value
                                                                      .dtAprv !=
                                                                  null &&
                                                              qcItem
                                                                      .value
                                                                      .dtAprv2 !=
                                                                  null
                                                          ? (
                                                            value,
                                                            remark,
                                                            fileImage,
                                                          ) {
                                                            checkboxEvent(
                                                              3,
                                                              qcItem
                                                                  .value
                                                                  .idQcItem,
                                                              context,
                                                              value: value,
                                                              remark,
                                                              fileImage,
                                                            );
                                                          }
                                                          : null,
                                                  checkboxApplicatorInitalValue:
                                                      qcItem.value.dtAprv !=
                                                      null,
                                                  checkboxInspectorInitalValue:
                                                      qcItem.value.dtAprv2 !=
                                                      null,
                                                  checkboxQCInitalValue:
                                                      qcItem.value.dtAprv3 !=
                                                      null,
                                                  title: qcItem.value.itemName,
                                                  content: Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(
                                                      8.w,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
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
                                                              if (qcItem
                                                                      .value
                                                                      .imgLink
                                                                      .isEmpty &&
                                                                  qcItem
                                                                      .value
                                                                      .imgLink2
                                                                      .isEmpty &&
                                                                  qcItem
                                                                      .value
                                                                      .imgLink3
                                                                      .isEmpty)
                                                                Container(
                                                                  child: Text(
                                                                    "No Attachment",
                                                                  ),
                                                                ),
                                                              if (qcItem
                                                                  .value
                                                                  .imgLink
                                                                  .isNotEmpty)
                                                                Padding(
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
                                                                      clipBehavior:
                                                                          Clip.hardEdge,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              2,
                                                                            ),
                                                                        color:
                                                                            Colors.grey[300],
                                                                      ),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl:
                                                                            qcItem.value.imgLink,
                                                                        progressIndicatorBuilder:
                                                                            (
                                                                              context,
                                                                              url,
                                                                              progress,
                                                                            ) => Center(
                                                                              child: CircularProgressIndicator(
                                                                                value:
                                                                                    progress.progress,
                                                                              ),
                                                                            ),
                                                                        fit:
                                                                            BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (qcItem
                                                                  .value
                                                                  .imgLink2
                                                                  .isNotEmpty)
                                                                Padding(
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
                                                                      clipBehavior:
                                                                          Clip.hardEdge,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              2,
                                                                            ),
                                                                        color:
                                                                            Colors.grey[300],
                                                                      ),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl:
                                                                            qcItem.value.imgLink2,
                                                                        progressIndicatorBuilder:
                                                                            (
                                                                              context,
                                                                              url,
                                                                              progress,
                                                                            ) => Center(
                                                                              child: CircularProgressIndicator(
                                                                                value:
                                                                                    progress.progress,
                                                                              ),
                                                                            ),
                                                                        fit:
                                                                            BoxFit.cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (qcItem
                                                                  .value
                                                                  .imgLink3
                                                                  .isNotEmpty)
                                                                Padding(
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
                                                                      clipBehavior:
                                                                          Clip.hardEdge,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              2,
                                                                            ),
                                                                        color:
                                                                            Colors.grey[300],
                                                                      ),
                                                                      child: CachedNetworkImage(
                                                                        imageUrl:
                                                                            qcItem.value.imgLink3,
                                                                        progressIndicatorBuilder:
                                                                            (
                                                                              context,
                                                                              url,
                                                                              progress,
                                                                            ) => Center(
                                                                              child: CircularProgressIndicator(
                                                                                value:
                                                                                    progress.progress,
                                                                              ),
                                                                            ),
                                                                        fit:
                                                                            BoxFit.cover,
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
                                              ),
                                            ],
                                          ),
                                        ),
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
              );
            }

            return SizedBox(
              height: 100.w,
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
