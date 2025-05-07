import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoneyInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxLines;

  const MoneyInputWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Use the passed controller
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _ThousandsFormatter(),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        border: UnderlineInputBorder(),
        suffixIcon: suffixIcon,
        fillColor: const Color(0xffffffff),
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: maxLines == 1 ? 0 : 12,
        ),
      ),
    );
  }
}

class _ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    // Remove all non-digit characters
    String cleanedText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Parse to int (handles leading zeros)
    int? parsedValue = int.tryParse(cleanedText);
    if (parsedValue == null) return TextEditingValue.empty;

    // Format with commas (e.g., 1234 → "1,234")
    String formattedText = NumberFormat('#,###').format(parsedValue);

    // Calculate new cursor position
    int originalCursorPos = newValue.selection.end;
    int commaCountBeforeCursor =
        formattedText
            .substring(0, originalCursorPos)
            .replaceAll(RegExp(r'[^,]'), '')
            .length;
    int newCursorPos = originalCursorPos + commaCountBeforeCursor;

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }
}
