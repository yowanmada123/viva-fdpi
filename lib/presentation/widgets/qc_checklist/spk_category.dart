import 'package:fdpi_app/bloc/QC/approve_detail/approve_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/authorization/credentials/credentials_bloc.dart';
import '../../../models/attachment.dart';
import 'approval_section.dart';

typedef CheckboxCallback =
    void Function(bool value, String remark, List<Attachment>? base64);
typedef ApproveDetailCallback = void Function(int idWok);
typedef UnapproveChecklistCallback = void Function(int idWork);
typedef UpdateApproveChecklistCallback =
    void Function(
      int idWork,
      String remark,
      List<Attachment>? fileImage,
      List<String> deleteImage,
    );

typedef UpdateCallback =
    void Function(
      String remark,
      List<Attachment>? fileImage,
      List<String> deleteImage,
    );

class SpkChecklistAccordion extends StatelessWidget {
  final int index;
  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final bool showIcon;
  final bool showCheckboxQC;
  final bool showCheckboxApplicator;
  final bool showCheckboxInspector;
  final bool? checkboxApplicatorInitalValue;
  final bool? checkboxInspectorInitalValue;
  final bool? checkboxQCInitalValue;
  final CheckboxCallback? onCheckboxApplicatorChanged;
  final CheckboxCallback? onCheckboxQCChanged;
  final CheckboxCallback? onCheckboxInspectorChanged;
  final ApproveDetailCallback? onApproveDetail;
  final UnapproveChecklistCallback? onUnapproveChecklist;
  final UpdateApproveChecklistCallback? onUpdateChecklist;

  const SpkChecklistAccordion({
    super.key,
    required this.index,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.showIcon = true,
    this.showCheckboxQC = false,
    this.showCheckboxApplicator = false,
    this.showCheckboxInspector = false,
    this.checkboxApplicatorInitalValue,
    this.checkboxInspectorInitalValue,
    this.checkboxQCInitalValue,
    this.onCheckboxQCChanged,
    this.onCheckboxApplicatorChanged,
    this.onCheckboxInspectorChanged,
    this.onApproveDetail,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: _AccordionContent(
        index: index,
        title: title,
        content: content,
        initiallyExpanded: initiallyExpanded,
        showIcon: showIcon,
        showCheckboxQC: showCheckboxQC,
        showCheckboxApplicator: showCheckboxApplicator,
        showCheckboxInspector: showCheckboxInspector,
        checkboxApplicatorInitalValue: checkboxApplicatorInitalValue,
        checkboxInspectorInitalValue: checkboxInspectorInitalValue,
        checkboxQCInitalValue: checkboxQCInitalValue,
        onCheckboxQCChanged: onCheckboxQCChanged,
        onCheckboxApplicatorChanged: onCheckboxApplicatorChanged,
        onCheckboxInspectorChanged: onCheckboxInspectorChanged,
        onApproveDetail: onApproveDetail,
        onUnapproveChecklist: onUnapproveChecklist,
        onUpdateChecklist: onUpdateChecklist,
      ),
    );
  }
}

class _AccordionContent extends StatefulWidget {
  final int index;
  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final bool showIcon;
  final bool showCheckboxQC;
  final bool showCheckboxApplicator;
  final bool showCheckboxInspector;
  final bool? checkboxApplicatorInitalValue;
  final bool? checkboxInspectorInitalValue;
  final bool? checkboxQCInitalValue;
  final CheckboxCallback? onCheckboxApplicatorChanged;
  final CheckboxCallback? onCheckboxQCChanged;
  final CheckboxCallback? onCheckboxInspectorChanged;
  final ApproveDetailCallback? onApproveDetail;
  final UnapproveChecklistCallback? onUnapproveChecklist;
  final UpdateApproveChecklistCallback? onUpdateChecklist;

  const _AccordionContent({
    required this.index,
    required this.title,
    required this.content,
    required this.initiallyExpanded,
    required this.showIcon,
    required this.showCheckboxQC,
    required this.showCheckboxApplicator,
    required this.showCheckboxInspector,
    this.checkboxApplicatorInitalValue,
    this.checkboxInspectorInitalValue,
    this.checkboxQCInitalValue,
    this.onCheckboxQCChanged,
    this.onCheckboxApplicatorChanged,
    this.onCheckboxInspectorChanged,
    this.onApproveDetail,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  State<_AccordionContent> createState() => _AccordionContentState();
}

class _AccordionContentState extends State<_AccordionContent> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.index % 2 == 0 ? Colors.white : const Color(0xffFAFAFA);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _HeaderSection(
          title: widget.title,
          isExpanded: _isExpanded,
          backgroundColor: backgroundColor,
          showIcon: widget.showIcon,
          showCheckboxQC: widget.showCheckboxQC,
          showCheckboxApplicator: widget.showCheckboxApplicator,
          showCheckboxInspector: widget.showCheckboxInspector,
          checkboxApplicatorValue:
              widget.checkboxApplicatorInitalValue ?? false,
          checkboxInspectorValue: widget.checkboxInspectorInitalValue ?? false,
          checkboxQCValue: widget.checkboxQCInitalValue ?? false,
          onCheckboxQCChanged: widget.onCheckboxQCChanged,
          onCheckboxApplicatorChanged: widget.onCheckboxApplicatorChanged,
          onCheckboxInspectorChanged: widget.onCheckboxInspectorChanged,
          onApproveDetail: widget.onApproveDetail,
          onUnapproveChecklist: widget.onUnapproveChecklist,
          onUpdateChecklist: widget.onUpdateChecklist,
          onHeaderTap: () => setState(() => _isExpanded = !_isExpanded),
        ),
        _ContentSection(
          isExpanded: _isExpanded,
          content: widget.content,
          backgroundColor: backgroundColor,
        ),
      ],
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final Color backgroundColor;
  final bool showIcon;
  final bool showCheckboxQC;
  final bool showCheckboxApplicator;
  final bool showCheckboxInspector;
  final bool checkboxQCValue;
  final bool checkboxApplicatorValue;
  final bool checkboxInspectorValue;
  final CheckboxCallback? onCheckboxQCChanged;
  final CheckboxCallback? onCheckboxApplicatorChanged;
  final CheckboxCallback? onCheckboxInspectorChanged;
  final ApproveDetailCallback? onApproveDetail;
  final VoidCallback onHeaderTap;
  final UnapproveChecklistCallback? onUnapproveChecklist;
  final UpdateApproveChecklistCallback? onUpdateChecklist;

  const _HeaderSection({
    required this.title,
    required this.isExpanded,
    required this.backgroundColor,
    required this.showIcon,
    required this.showCheckboxQC,
    required this.showCheckboxApplicator,
    required this.showCheckboxInspector,
    required this.checkboxQCValue,
    required this.checkboxApplicatorValue,
    required this.checkboxInspectorValue,
    this.onCheckboxQCChanged,
    this.onCheckboxApplicatorChanged,
    this.onCheckboxInspectorChanged,
    this.onApproveDetail,
    required this.onHeaderTap,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onHeaderTap,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor),
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (showIcon)
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                ],
              ),
            ),
            if (showCheckboxApplicator)
              _AuthorizedCheckbox(
                value: checkboxApplicatorValue,
                label: 'Pelaksana',
                authorizationKey: 'CEK_LIST_1',
                onChanged: onCheckboxApplicatorChanged,
                onBeforeDialog: () => onApproveDetail?.call(1),
                onUnapproveChecklist: () => onUnapproveChecklist?.call(1),
                onUpdateChecklist:
                    (remark, file, deleteImage) =>
                        onUpdateChecklist?.call(1, remark, file, deleteImage),
              ),
            if (showCheckboxInspector)
              _AuthorizedCheckbox(
                value: checkboxInspectorValue,
                label: 'Pemeriksa',
                authorizationKey: 'CEK_LIST_2',
                onChanged: onCheckboxInspectorChanged,
                onBeforeDialog: () => onApproveDetail?.call(2),
                onUnapproveChecklist: () => onUnapproveChecklist?.call(2),
                onUpdateChecklist:
                    (remark, file, deleteImage) =>
                        onUpdateChecklist?.call(2, remark, file, deleteImage),
              ),
            if (showCheckboxQC)
              _AuthorizedCheckbox(
                value: checkboxQCValue,
                label: 'QC',
                authorizationKey: 'CEK_LIST_1',
                onChanged: onCheckboxQCChanged,
                onBeforeDialog: () => onApproveDetail?.call(3),
                onUnapproveChecklist: () => onUnapproveChecklist?.call(3),
                onUpdateChecklist:
                    (remark, file, deleteImage) =>
                        onUpdateChecklist?.call(3, remark, file, deleteImage),
              ),
          ],
        ),
      ),
    );
  }
}

class _AuthorizedCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final String authorizationKey;
  final CheckboxCallback? onChanged;
  final VoidCallback? onBeforeDialog;
  final VoidCallback? onUnapproveChecklist;
  final UpdateCallback? onUpdateChecklist;

  const _AuthorizedCheckbox({
    required this.value,
    required this.label,
    required this.authorizationKey,
    this.onChanged,
    this.onBeforeDialog,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      child: Column(
        children: [
          Checkbox(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: value,
            onChanged:
                onChanged == null
                    ? null
                    : (newValue) => _handleCheckboxChange(context, newValue),
          ),
          Text(label, style: TextStyle(fontSize: 8.sp)),
        ],
      ),
    );
  }

  void _handleCheckboxChange(BuildContext context, bool? newValue) {
    final bloc = context.read<CredentialsBloc>();
    final state = bloc.state;
    final approveDetailBloc = BlocProvider.of<ApproveDetailBloc>(context);

    if (state is! CredentialsLoadSuccess) return;

    if (state.credentials[authorizationKey] != "Y") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Doesn't have authorization"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    onBeforeDialog?.call();
    showDialog(
      context: context,
      builder:
          (context) => _CheckboxConfirmationDialog(
            onConfirmed: (remark, attachments) {
              onChanged?.call(!value, remark, attachments);
            },
            approveDetailBloc: approveDetailBloc,
            onUnapproveChecklist: onUnapproveChecklist,
            onUpdateChecklist: onUpdateChecklist,
            value: value,
          ),
    );
  }
}

class _CheckboxConfirmationDialog extends StatefulWidget {
  final void Function(String remark, List<Attachment>? attachments) onConfirmed;
  final ApproveDetailBloc approveDetailBloc;
  final bool value;
  final VoidCallback? onUnapproveChecklist;
  final UpdateCallback? onUpdateChecklist;

  const _CheckboxConfirmationDialog({
    required this.onConfirmed,
    required this.approveDetailBloc,
    required this.value,
    required this.onUnapproveChecklist,
    required this.onUpdateChecklist,
  });

  @override
  State<_CheckboxConfirmationDialog> createState() =>
      _CheckboxConfirmationDialogState();
}

class _CheckboxConfirmationDialogState
    extends State<_CheckboxConfirmationDialog> {
  final TextEditingController _remarkController = TextEditingController();
  List<Attachment>? _attachments;

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: BlocProvider.value(
        value: widget.approveDetailBloc,
        child: SingleChildScrollView(
          child: BlocBuilder<ApproveDetailBloc, ApproveDetailState>(
            builder: (context, state) {
              if (state is! ApproveDetailSuccess) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              _remarkController.text = state.detailApproveResponse.remark;

              return Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Approve',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    const Text(
                      'Remark',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.w),
                    TextField(
                      controller: _remarkController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter your remark...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.w),
                    const Text(
                      'Attachment',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.w),
                    FileAttachmentPicker(
                      onAttachmentsChanged: (attachments) {
                        _attachments = attachments;
                      },
                    ),
                    SizedBox(height: 16.w),
                    if (!widget.value)
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFAFAFAF),
                              ),
                              child: const Text('Close'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: FilledButton(
                              child: const Text('Approve'),
                              onPressed: () {
                                widget.onConfirmed(
                                  _remarkController.text,
                                  _attachments,
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    if (widget.value)
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFAFAFAF),
                              ),
                              child: const Text('Reject'),
                              onPressed: () {
                                widget.onUnapproveChecklist?.call();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: FilledButton(
                              child: const Text('Update'),
                              onPressed: () {
                                widget.onUpdateChecklist?.call(
                                  _remarkController.text,
                                  _attachments,
                                  [],
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  final bool isExpanded;
  final Widget content;
  final Color backgroundColor;

  const _ContentSection({
    required this.isExpanded,
    required this.content,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(color: backgroundColor),
        child: isExpanded ? content : const SizedBox.shrink(),
      ),
    );
  }
}
