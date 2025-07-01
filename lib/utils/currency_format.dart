import 'package:intl/intl.dart';

String formatIDRCurrency(dynamic input) {
  try {
    if (input == null) return _defaultResult();

    final strValue = input.toString().trim();
    if (strValue.isEmpty) return _defaultResult();

    String normalized = strValue.replaceAll(RegExp(r'[^0-9.]'), '');

    if (normalized.startsWith('.')) normalized = '0$normalized';

    final parts = normalized.split('.');
    final integerPart = parts[0].replaceAll(RegExp(r'^0+'), '').padLeft(1, '0');

    String fractionalPart = (parts.length > 1) ? parts[1] : '';
    fractionalPart = fractionalPart.padRight(2, '0').substring(0, 2);

    final bigInt = BigInt.parse(integerPart.isEmpty ? '0' : integerPart);
    final formattedInteger = NumberFormat('#,##0', 'id_ID').format(bigInt);

    return 'Rp. $formattedInteger,$fractionalPart';
  } catch (_) {
    return _defaultResult();
  }
}

String _defaultResult() => 'Rp. 0,00';
