import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/QC/approve_detail/approve_detail_bloc.dart';
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

class SprChecklistAccordion extends StatefulWidget {
  final int index;
  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final bool showIcon;
  final bool showCheckboxApplicator;
  final bool? checkboxApplicatorInitalValue;
  final CheckboxCallback? onCheckboxApplicatorChanged;
  final ApproveDetailCallback? onApproveDetail;
  final UnapproveChecklistCallback? onUnapproveChecklist;
  final UpdateApproveChecklistCallback? onUpdateChecklist;

  const SprChecklistAccordion({
    super.key,
    required this.index,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.showIcon = true,
    this.showCheckboxApplicator = false,
    this.checkboxApplicatorInitalValue,
    this.onCheckboxApplicatorChanged,
    this.onApproveDetail,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  State<SprChecklistAccordion> createState() => _SprChecklistAccordionState();
}

class _SprChecklistAccordionState extends State<SprChecklistAccordion> {
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

    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _HeaderSection(
            title: widget.title,
            isExpanded: _isExpanded,
            backgroundColor: backgroundColor,
            showIcon: widget.showIcon,
            showCheckboxApplicator: widget.showCheckboxApplicator,
            checkboxApplicatorValue:
                widget.checkboxApplicatorInitalValue ?? false,
            onCheckboxApplicatorChanged: widget.onCheckboxApplicatorChanged,
            onHeaderTap: () => setState(() => _isExpanded = !_isExpanded),
            onApproveDetail: widget.onApproveDetail,
            onUnapproveChecklist: widget.onUnapproveChecklist,
            onUpdateChecklist: widget.onUpdateChecklist,
          ),
          _ContentSection(
            isExpanded: _isExpanded,
            content: widget.content,
            backgroundColor: backgroundColor,
          ),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final Color backgroundColor;
  final bool showIcon;
  final bool showCheckboxApplicator;
  final bool checkboxApplicatorValue;
  final CheckboxCallback? onCheckboxApplicatorChanged;
  final VoidCallback onHeaderTap;
  final ApproveDetailCallback? onApproveDetail;
  final UnapproveChecklistCallback? onUnapproveChecklist;
  final UpdateApproveChecklistCallback? onUpdateChecklist;

  const _HeaderSection({
    required this.title,
    required this.isExpanded,
    required this.backgroundColor,
    required this.showIcon,
    required this.showCheckboxApplicator,
    required this.checkboxApplicatorValue,
    this.onCheckboxApplicatorChanged,
    required this.onHeaderTap,
    this.onApproveDetail,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onHeaderTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(4.0),
            topRight: const Radius.circular(4.0),
            bottomLeft: Radius.circular(isExpanded ? 0 : 4.0),
            bottomRight: Radius.circular(isExpanded ? 0 : 4.0),
          ),
        ),
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
                onChanged: onCheckboxApplicatorChanged,
                onBeforeDialog: () => onApproveDetail?.call(1),
                onUnapproveChecklist: () => onUnapproveChecklist?.call(1),
                onUpdateChecklist:
                    (remark, file, deleteImage) =>
                        onUpdateChecklist?.call(1, remark, file, deleteImage),
              ),
          ],
        ),
      ),
    );
  }
}

class _AuthorizedCheckbox extends StatelessWidget {
  final bool value;
  final CheckboxCallback? onChanged;
  final VoidCallback? onBeforeDialog;
  final VoidCallback? onUnapproveChecklist;
  final UpdateCallback? onUpdateChecklist;

  const _AuthorizedCheckbox({
    required this.value,
    this.onChanged,
    this.onBeforeDialog,
    this.onUnapproveChecklist,
    this.onUpdateChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48.w,
      child: Checkbox(
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
    );
  }

  void _handleCheckboxChange(BuildContext context, bool? newValue) {
    final bloc = context.read<CredentialsBloc>();
    final state = bloc.state;
    final approveDetailBloc = BlocProvider.of<ApproveDetailBloc>(context);

    if (state is! CredentialsLoadSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Authorization not available"),
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
  final VoidCallback? onUnapproveChecklist;
  final UpdateCallback? onUpdateChecklist;
  final bool value;

  const _CheckboxConfirmationDialog({
    required this.onConfirmed,
    required this.approveDetailBloc,
    required this.onUnapproveChecklist,
    required this.onUpdateChecklist,
    required this.value,
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
                    Text(
                      'Konfirmasi',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 16.w),
                    Text(
                      'Remark',
                      style: Theme.of(context).textTheme.titleMedium,
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
                    Text(
                      'Attachment',
                      style: Theme.of(context).textTheme.titleMedium,
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
                              child: const Text('Konfirmasi'),
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
                              child: const Text('Unapprove'),
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
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(4.0),
            bottomRight: Radius.circular(4.0),
          ),
        ),
        child: isExpanded ? content : const SizedBox.shrink(),
      ),
    );
  }
}
