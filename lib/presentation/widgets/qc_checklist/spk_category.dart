import 'package:fdpi_app/bloc/QC/approve_detail/approve_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/authorization/credentials/credentials_bloc.dart';
import '../../../models/attachment.dart';
import 'approval_section.dart';

typedef CheckboxCallback =
    void Function(bool value, String remark, List<Attachment>? base64);

typedef SaveCallback =
    void Function(
      String remark,
      List<Attachment>? attachments,
      List<String> deleteImage,
    );

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
  final SaveCallback? onSave;
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
    this.onSave,
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
        onSave: onSave,
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
  final SaveCallback? onSave;
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
    this.onSave,
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
          onSave: widget.onSave,
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
  final SaveCallback? onSave;
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
    this.onSave,
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
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
                onSave: onSave,
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
                onSave: onSave,
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
                authorizationKey: 'CEK_LIST_3',
                onSave: onSave,
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
  final SaveCallback? onSave;
  final VoidCallback? onBeforeDialog;
  final VoidCallback? onUnapproveChecklist;
  final UpdateCallback? onUpdateChecklist;

  const _AuthorizedCheckbox({
    required this.value,
    required this.label,
    required this.authorizationKey,
    this.onChanged,
    this.onSave,
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

    if (state is! CredentialsLoadSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Authorization not available"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

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
            onSave: onSave,
            approveDetailBloc: approveDetailBloc,
            onUnapproveChecklist: onUnapproveChecklist,
            onUpdateChecklist: onUpdateChecklist,
            value: value,
            isApproved: value,
          ),
    );
  }
}

class _CheckboxConfirmationDialog extends StatefulWidget {
  final void Function(String remark, List<Attachment>? attachments) onConfirmed;
  final void Function(String, List<Attachment>?, List<String>)? onSave;
  final ApproveDetailBloc approveDetailBloc;
  final VoidCallback? onUnapproveChecklist;
  final UpdateCallback? onUpdateChecklist;
  final bool value;
  final bool isApproved;

  const _CheckboxConfirmationDialog({
    required this.onConfirmed,
    required this.approveDetailBloc,
    required this.onUnapproveChecklist,
    required this.onUpdateChecklist,
    required this.value,
    this.onSave,
    required this.isApproved,
  });

  @override
  State<_CheckboxConfirmationDialog> createState() =>
      _CheckboxConfirmationDialogState();
}

class _CheckboxConfirmationDialogState
    extends State<_CheckboxConfirmationDialog> {
  final TextEditingController _remarkController = TextEditingController();

  List<String> _existingImages = [];
  final List<Attachment> _newImages = [];
  final Set<String> _deletedImages = {};

  bool _isInitialized = false;

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

              final detail = state.detailApproveResponse;

              if (!_isInitialized) {
                _remarkController.text = detail.remark;
                _existingImages = List<String>.from(detail.imgLinks);
                _isInitialized = true;
              }

              int totalImage = _existingImages.length + _newImages.length;

              return Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Approve',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close, size: 30.w),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.w),

                    /// ================= REMARK =================
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

                    SizedBox(height: 8.w),

                    /// ================= ATTACHMENT =================
                    Text(
                      'Existing Attachment',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    SizedBox(height: 8.w),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...List.generate(_existingImages.length, (index) {
                          final img = _existingImages[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Stack(
                              children: [
                                Image.network(
                                  img,
                                  width: 64.w,
                                  height: 64.w,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _existingImages.removeAt(index);
                                        _deletedImages.add(img.split('/').last);
                                      });
                                    },
                                    child: Container(
                                      color: Colors.black54,
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        ...List.generate(_newImages.length, (index) {
                          final file = _newImages[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Stack(
                              children: [
                                Image.file(
                                  file.file,
                                  width: 64.w,
                                  height: 64.w,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _newImages.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      color: Colors.black54,
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),

                    SizedBox(height: 8.w),

                    if (totalImage < 3)
                      FileAttachmentPicker(
                        onAttachmentsChanged: (attachments) {
                          setState(() {
                            for (final attachment in attachments) {
                              final isDuplicate = _newImages.any(
                                (e) =>
                                    e.name == attachment.name &&
                                    e.base64 == attachment.base64,
                              );

                              final totalImage =
                                  _existingImages.length + _newImages.length;

                              if (!isDuplicate && totalImage < 3) {
                                _newImages.add(attachment);
                              }
                            }
                          });
                        },
                      ),

                    SizedBox(height: 16.w),

                    /// ================= BUTTON =================
                    if (!widget.isApproved)
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFFAFAFAF),
                              ),
                              child: const Text('Save'),
                              onPressed: () {
                                widget.onSave?.call(
                                  _remarkController.text,
                                  _newImages.isEmpty ? null : _newImages,
                                  _deletedImages.toList(),
                                );

                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),

                          Expanded(
                            child: FilledButton(
                              child: const Text('Approve'),
                              onPressed: () {
                                widget.onConfirmed(
                                  _remarkController.text,
                                  _newImages.isEmpty ? null : _newImages,
                                );

                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),

                    if (widget.isApproved)
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
                                  _newImages.isEmpty ? null : _newImages,
                                  _deletedImages.toList(),
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
        padding:
            isExpanded
                ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
                : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
