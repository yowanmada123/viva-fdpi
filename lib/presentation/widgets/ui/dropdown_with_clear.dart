import 'package:flutter/material.dart';

class DropdownWithClear<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? hintText;
  final ValueChanged<T?> onChanged;
  final Widget? clearIcon;
  final EdgeInsetsGeometry? padding;
  final Decoration? dropdownDecoration;
  final double dropdownWidth;

  const DropdownWithClear({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,
    this.clearIcon,
    this.padding,
    this.dropdownDecoration,
    this.dropdownWidth = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: dropdownWidth,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
            decoration:
                dropdownDecoration ??
                BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                hint:
                    hintText != null
                        ? Text(
                          hintText!,
                          style: TextStyle(color: Colors.grey[600]),
                        )
                        : null,
                items: items,
                onChanged: onChanged,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Clear button that appears only when value is selected
                      if (value != null)
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => onChanged(null),
                            child:
                                clearIcon ??
                                Icon(
                                  Icons.clear,
                                  size: 16,
                                  color: Colors.grey[900],
                                ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 24,
                        color:
                            items.isNotEmpty ? Colors.grey[900] : Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
