import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/QC/approve_checklist/approve_checklist_bloc.dart';
import '../../bloc/QC/spr_checklist/spr_checklist_bloc.dart';
import '../../data/repository/spk_repository.dart';
import '../../models/attachment.dart';
import '../widgets/qc_checklist/spr_checklist.dart';

class SprProgressListScreen extends StatelessWidget {
  final String qcTransId;
  const SprProgressListScreen({super.key, required this.qcTransId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  SprChecklistBloc(spkRepository: context.read<SPKRepository>())
                    ..add(LoadSprChecklist(qcTransId: qcTransId)),
        ),
        BlocProvider(
          create:
              (context) => ApproveChecklistBloc(
                spkRepository: context.read<SPKRepository>(),
              ),
        ),
      ],
      child: _SprProgressListScreenContent(qcTransId: qcTransId),
    );
  }
}

class _SprProgressListScreenContent extends StatefulWidget {
  final String qcTransId;
  const _SprProgressListScreenContent({required this.qcTransId});

  @override
  State<_SprProgressListScreenContent> createState() =>
      _SprProgressListScreenContentState();
}

class _SprProgressListScreenContentState
    extends State<_SprProgressListScreenContent> {
  final TextEditingController _remarkController = TextEditingController();

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Check List', style: TextStyle(fontSize: 20.sp)),
      ),
      body: BlocListener<ApproveChecklistBloc, ApproveChecklistState>(
        listener: (context, state) {
          if (state is ApproveChecklistLoadSuccess) {
            context.read<SprChecklistBloc>().add(
              LoadSprChecklist(qcTransId: widget.qcTransId),
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
        child: BlocBuilder<SprChecklistBloc, SprChecklistState>(
          builder: (context, state) {
            if (state is SprChecklistLoadSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children:
                        state.sprChecklistItem.asMap().entries.map<Widget>((
                          qcItem,
                        ) {
                          return SprChecklistAccordion(
                            index: qcItem.key,
                            title: qcItem.value.itemName,
                            padding: EdgeInsets.all(16.w),
                            onCheckboxApplicatorChanged:
                                qcItem.value.statClosing == 'N'
                                    ? (value, remark, fileImage) {
                                      checkboxEvent(
                                        1,
                                        qcItem.value.idQcItem,
                                        context,
                                        value: value,
                                        remark,
                                        fileImage,
                                      );
                                    }
                                    : null,
                            showIcon: false,
                            showCheckboxApplicator: true,
                            checkboxApplicatorInitalValue:
                                qcItem.value.dtAprv != null,
                            titleStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.sp,
                            ),
                            content: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Attachment",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.w),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        if (qcItem.value.imgLink.isEmpty &&
                                            qcItem.value.imgLink2.isEmpty &&
                                            qcItem.value.imgLink3.isEmpty)
                                          Container(
                                            child: Text("No Attachment"),
                                          ),
                                        if (qcItem.value.imgLink.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 4.w,
                                            ),
                                            child: SizedBox(
                                              width: 64.w,
                                              height: 64.w,
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: Colors.grey[300],
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
                                                        child:
                                                            CircularProgressIndicator(
                                                              value:
                                                                  progress
                                                                      .progress,
                                                            ),
                                                      ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (qcItem.value.imgLink2.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 4.w,
                                            ),
                                            child: SizedBox(
                                              width: 64.w,
                                              height: 64.w,
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: Colors.grey[300],
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
                                                        child:
                                                            CircularProgressIndicator(
                                                              value:
                                                                  progress
                                                                      .progress,
                                                            ),
                                                      ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (qcItem.value.imgLink3.isNotEmpty)
                                          Padding(
                                            padding: EdgeInsets.only(
                                              right: 4.w,
                                            ),
                                            child: SizedBox(
                                              width: 64.w,
                                              height: 64.w,
                                              child: Container(
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: Colors.grey[300],
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
                                                        child:
                                                            CircularProgressIndicator(
                                                              value:
                                                                  progress
                                                                      .progress,
                                                            ),
                                                      ),
                                                  fit: BoxFit.cover,
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
                          );
                        }).toList(),
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
