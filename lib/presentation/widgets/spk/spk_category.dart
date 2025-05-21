import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final bool? checkboxValue;
  final ValueChanged<bool?>? onCheckboxQCChanged;
  final ValueChanged<bool?>? onCheckboxApplicatorChanged;
  final ValueChanged<bool?>? onCheckboxInspectorChanged;

  const SpkChecklistAccordion({
    Key? key,
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
    this.checkboxValue,
    this.onCheckboxQCChanged,
    this.onCheckboxApplicatorChanged,
    this.onCheckboxInspectorChanged,
  }) : super(key: key);

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
    final theme = Theme.of(context);
    final headerColor =
        widget.backgroundColor != null
            ? widget.backgroundColor
            : widget.index % 2 == 0
            ? Colors.white
            : Color(0xffFAFAFA);
    final contentColor =
        widget.backgroundColor != null
            ? widget.backgroundColor
            : widget.index % 2 == 0
            ? Colors.white
            : Color(0xffFAFAFA);
    final titleStyle = widget.titleStyle ?? theme.textTheme.titleMedium;

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
                  child: InkWell(
                    onTap: () => setState(() => _isExpanded = !_isExpanded),
                    child: Row(
                      children: [
                        Expanded(child: Text(widget.title, style: titleStyle)),
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
                          value: widget.checkboxValue ?? false,
                          onChanged: widget.onCheckboxApplicatorChanged,
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
                          value: widget.checkboxValue ?? false,
                          onChanged: widget.onCheckboxInspectorChanged,
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
                          value: widget.checkboxValue ?? false,
                          onChanged: widget.onCheckboxQCChanged,
                        ),
                        Text('QC', style: TextStyle(fontSize: 8.sp)),
                      ],
                    ),
                  ),

                if (widget.trailing != null) widget.trailing!,
              ],
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
    );
  }
}
