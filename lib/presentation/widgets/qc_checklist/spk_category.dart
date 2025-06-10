import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/authorization/credentials/credentials_bloc.dart';
import '../../../models/attachment.dart';
import 'approval_section.dart';

typedef CheckboxCallback =
    void Function(bool value, String remark, List<Attachment>? base64);

class SpkChecklistAccordion extends StatefulWidget {
  final int index;
  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final Duration animationDuration;
  final EdgeInsetsGeometry? padding;
  final Color? headerBackgroundColor;
  final Color? contentBackgroundColor;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final double borderRadius;
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

  const SpkChecklistAccordion({
    super.key,
    required this.index,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.padding,
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.backgroundColor,
    this.leading,
    this.trailing,
    this.titleStyle,
    this.borderRadius = 0.0,
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
  });

  @override
  _SpkChecklistAccordionState createState() => _SpkChecklistAccordionState();
}

class _SpkChecklistAccordionState extends State<SpkChecklistAccordion> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    bool checkboxQCValue = widget.checkboxQCInitalValue ?? false;
    bool checkboxApplicatorValue =
        widget.checkboxApplicatorInitalValue ?? false;
    bool checkboxInspectorValue = widget.checkboxInspectorInitalValue ?? false;
    final TextEditingController remarkController = TextEditingController();

    @override
    void dispose() {
      remarkController.dispose();
      super.dispose();
    }

    final theme = Theme.of(context);
    final headerColor =
        widget.backgroundColor ??
        (widget.index % 2 == 0 ? Colors.white : Color(0xffFAFAFA));
    final contentColor =
        widget.backgroundColor ??
        (widget.index % 2 == 0 ? Colors.white : Color(0xffFAFAFA));
    final titleStyle = widget.titleStyle ?? theme.textTheme.titleMedium;

    return BlocProvider.value(
      value: context.read<CredentialsBloc>(),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Container(
                decoration: BoxDecoration(
                  color: headerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    topRight: Radius.circular(widget.borderRadius),
                    bottomLeft: Radius.circular(
                      _isExpanded ? 0 : widget.borderRadius,
                    ),
                    bottomRight: Radius.circular(
                      _isExpanded ? 0 : widget.borderRadius,
                    ),
                  ),
                ),
                padding: widget.padding ?? const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (widget.leading != null) ...[
                      widget.leading!,
                      const SizedBox(width: 12),
                    ],

                    // Expanded area with InkWell wrapping just the text
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(widget.title, style: titleStyle),
                          ),
                          if (widget.showIcon)
                            Icon(
                              _isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                        ],
                      ),
                    ),

                    // Checkbox placed outside the InkWell
                    if (widget.showCheckboxApplicator)
                      SizedBox(
                        width: 48.w,
                        child: Column(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              value: checkboxApplicatorValue,
                              onChanged:
                                  widget.onCheckboxApplicatorChanged == null
                                      ? null
                                      : (value) {
                                        final bloc =
                                            BlocProvider.of<CredentialsBloc>(
                                              context,
                                            );
                                        final state = bloc.state;

                                        if (state is CredentialsLoadSuccess) {
                                          if (state.credentials['CEK_LIST_1'] ==
                                              "Y") {
                                            // 1. Add a StatefulBuilder to update dialog state
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                List<Attachment>? fileImage;

                                                return StatefulBuilder(
                                                  builder: (
                                                    context,
                                                    setDialogState,
                                                  ) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16.w,
                                                          ),
                                                      child: SingleChildScrollView(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                16.w,
                                                              ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Konfirmasi',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Text(
                                                                'Remark',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.w,
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    remarkController,
                                                                maxLines: 3,
                                                                decoration: InputDecoration(
                                                                  hintText:
                                                                      'Enter your remark...',
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10.w,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Text(
                                                                'Attachment',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.w,
                                                              ),
                                                              FileAttachmentPicker(
                                                                onAttachmentsChanged: (
                                                                  attachments,
                                                                ) {
                                                                  // Handle the list of attachments
                                                                  setState(() {
                                                                    fileImage =
                                                                        attachments;
                                                                  });
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: FilledButton(
                                                                      style: FilledButton.styleFrom(
                                                                        backgroundColor: Color.fromARGB(
                                                                          255,
                                                                          175,
                                                                          175,
                                                                          175,
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                        'Close',
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 16.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: FilledButton(
                                                                      child: Text(
                                                                        'Konfirmasi',
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                        String
                                                                        remark =
                                                                            remarkController.text.toString();
                                                                        widget
                                                                            .onCheckboxApplicatorChanged!(
                                                                          !checkboxApplicatorValue,
                                                                          remark,
                                                                          fileImage,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                            // widget.onCheckboxQCChanged!(value);
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Doesn't have authorization",
                                                ),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        }
                                      },
                            ),
                            Text('Pelaksana', style: TextStyle(fontSize: 8.sp)),
                          ],
                        ),
                      ),

                    if (widget.showCheckboxInspector)
                      SizedBox(
                        width: 48.w,
                        child: Column(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              value: checkboxInspectorValue,
                              onChanged:
                                  widget.onCheckboxInspectorChanged == null
                                      ? null
                                      : (value) {
                                        final bloc =
                                            BlocProvider.of<CredentialsBloc>(
                                              context,
                                            );
                                        final state = bloc.state;

                                        if (state is CredentialsLoadSuccess) {
                                          if (state.credentials['CEK_LIST_2'] ==
                                              "Y") {
                                            // 1. Add a StatefulBuilder to update dialog state
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                List<Attachment>? fileImage;

                                                return StatefulBuilder(
                                                  builder: (
                                                    context,
                                                    setDialogState,
                                                  ) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16.w,
                                                          ),
                                                      child: SingleChildScrollView(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                16.w,
                                                              ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Konfirmasi',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Text(
                                                                'Remark',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.w,
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    remarkController,
                                                                maxLines: 3,
                                                                decoration: InputDecoration(
                                                                  hintText:
                                                                      'Enter your remark...',
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10.w,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Text(
                                                                'Attachment',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.w,
                                                              ),
                                                              FileAttachmentPicker(
                                                                onAttachmentsChanged: (
                                                                  attachments,
                                                                ) {
                                                                  // Handle the list of attachments
                                                                  setState(() {
                                                                    fileImage =
                                                                        attachments;
                                                                  });
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: FilledButton(
                                                                      style: FilledButton.styleFrom(
                                                                        backgroundColor: Color.fromARGB(
                                                                          255,
                                                                          175,
                                                                          175,
                                                                          175,
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                        'Close',
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 16.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: FilledButton(
                                                                      child: Text(
                                                                        'Konfirmasi',
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                        String
                                                                        remark =
                                                                            remarkController.text.toString();
                                                                        widget
                                                                            .onCheckboxInspectorChanged!(
                                                                          !checkboxInspectorValue,
                                                                          remark,
                                                                          fileImage,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                            // widget.onCheckboxQCChanged!(value);
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Doesn't have authorization",
                                                ),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        }
                                      },
                            ),
                            Text('Pemeriksa', style: TextStyle(fontSize: 8.sp)),
                          ],
                        ),
                      ),

                    if (widget.showCheckboxQC)
                      SizedBox(
                        width: 48.w,
                        child: Column(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              value: checkboxQCValue,
                              onChanged:
                                  widget.onCheckboxQCChanged == null
                                      ? null
                                      : (value) {
                                        final bloc =
                                            BlocProvider.of<CredentialsBloc>(
                                              context,
                                            );
                                        final state = bloc.state;

                                        if (state is CredentialsLoadSuccess) {
                                          if (state.credentials['CEK_LIST_1'] ==
                                              "Y") {
                                            // 1. Add a StatefulBuilder to update dialog state
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                List<Attachment>? fileImage;

                                                return StatefulBuilder(
                                                  builder: (
                                                    context,
                                                    setDialogState,
                                                  ) {
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.white,
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 16.w,
                                                          ),
                                                      child: SingleChildScrollView(
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                16.w,
                                                              ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Konfirmasi',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Text(
                                                                'Remark',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.w,
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    remarkController,
                                                                maxLines: 3,
                                                                decoration: InputDecoration(
                                                                  hintText:
                                                                      'Enter your remark...',
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          10.w,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Text(
                                                                'Attachment',
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8.w,
                                                              ),
                                                              FileAttachmentPicker(
                                                                onAttachmentsChanged: (
                                                                  attachments,
                                                                ) {
                                                                  // Handle the list of attachments
                                                                  setState(() {
                                                                    fileImage =
                                                                        attachments;
                                                                  });
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.w,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: FilledButton(
                                                                      style: FilledButton.styleFrom(
                                                                        backgroundColor: Color.fromARGB(
                                                                          255,
                                                                          175,
                                                                          175,
                                                                          175,
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                        'Close',
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 16.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: FilledButton(
                                                                      child: Text(
                                                                        'Konfirmasi',
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                        String
                                                                        remark =
                                                                            remarkController.text.toString();
                                                                        widget
                                                                            .onCheckboxQCChanged!(
                                                                          !checkboxQCValue,
                                                                          remark,
                                                                          fileImage,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                            // widget.onCheckboxQCChanged!(value);
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Doesn't have authorization",
                                                ),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        }
                                      },
                            ),
                            Text('QC', style: TextStyle(fontSize: 8.sp)),
                          ],
                        ),
                      ),

                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
              ),
            ),

            // Content area
            AnimatedSize(
              duration: widget.animationDuration,
              child: Container(
                decoration: BoxDecoration(
                  color: contentColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(widget.borderRadius),
                    bottomRight: Radius.circular(widget.borderRadius),
                  ),
                ),
                child:
                    _isExpanded
                        ? Padding(
                          padding: widget.padding ?? EdgeInsets.all(0.w),
                          child: widget.content,
                        )
                        : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
