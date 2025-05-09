import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/QC/approve_checklist/approve_checklist_bloc.dart';
import '../../bloc/QC/checklist/checklist_bloc.dart';
import '../../data/repository/spk_repository.dart';

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
                  ChecklistBloc(spkRepository: context.read<SPKRepository>())
                    ..add(LoadChecklist(qcTransId: qcTransId)),
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
  int? _currentExpandedIndex;
  final TextEditingController _remarkController = TextEditingController();

  void _showApprovalBottomSheet({
    required BuildContext context,
    required String qcTransId,
    required String category,
    required String itemId,
    required bool currentApprovalStatus,
    required String itemName,
    required ApproveChecklistBloc approveChecklistBloc,
    required ChecklistBloc checklistBloc,
  }) {
    _remarkController.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white, // Add background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: approveChecklistBloc),
            BlocProvider.value(value: checklistBloc),
          ],
          child: BlocListener<ApproveChecklistBloc, ApproveChecklistState>(
            listener: (context, state) {
              if (state is ApproveChecklistLoadSuccess) {
                // Refresh checklist data
                checklistBloc.add(LoadChecklist(qcTransId: qcTransId));
                Navigator.pop(context);

                // Optional: Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remark for $itemName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _remarkController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter your remark...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 16),
                      BlocBuilder<ApproveChecklistBloc, ApproveChecklistState>(
                        builder: (context, state) {
                          return Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1C3FAA),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed:
                                  state is ApproveChecklistLoading
                                      ? null // Disable button when loading
                                      : () {
                                        approveChecklistBloc.add(
                                          ApproveChecklistEventInit(
                                            qcTransId: qcTransId,
                                            idQcItem: itemId,
                                            remark: _remarkController.text,
                                          ),
                                        );
                                      },
                              child:
                                  state is ApproveChecklistLoading
                                      ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                      : Text(
                                        currentApprovalStatus
                                            ? 'Unapprove'
                                            : 'Approve',
                                        style: TextStyle(color: Colors.white),
                                      ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SPR Progress', style: TextStyle(fontSize: 20.sp)),
      ),
      body: BlocBuilder<ChecklistBloc, ChecklistState>(
        builder: (context, state) {
          if (state is ChecklistLoadSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var entry in state.checklistItem.entries)
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children:
                            (entry.value as Map<String, dynamic>)['data']
                                .map<Widget>((item) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    margin: EdgeInsets.only(bottom: 8.0),
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(item.qcItem),
                                      value: item.aprvBy.isNotEmpty,
                                      onChanged: (bool? newValue) {
                                        _showApprovalBottomSheet(
                                          context: context,
                                          qcTransId: widget.qcTransId,
                                          category: entry.key,
                                          itemId: item.idQcItem,
                                          currentApprovalStatus:
                                              item.aprvBy.isNotEmpty,
                                          itemName: item.qcItem,
                                          approveChecklistBloc:
                                              context
                                                  .read<ApproveChecklistBloc>(),
                                          checklistBloc:
                                              context.read<ChecklistBloc>(),
                                        );
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  );
                                })
                                .toList(),
                      ),
                    ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
