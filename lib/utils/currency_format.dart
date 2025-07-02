String formatIDRCurrency(dynamic input) {
  try {
    if (input == null) return _defaultResult();
 
    final strValue = input.toString().trim();
    if (strValue.isEmpty) return _defaultResult();
 
    String normalized = strValue.replaceAll(RegExp(r'[^0-9.]'), '');
 
    if (normalized.startsWith('.')) normalized = '0$normalized';
 
    final parts = normalized.split('.');
    String integerPart = parts[0].replaceAll(RegExp(r'^0+'), '').padLeft(1, '0');
 
    String fractionalPart = (parts.length > 1) ? parts[1] : '';
    fractionalPart = fractionalPart.padRight(2, '0').substring(0, 2);
 
    // Format the integer part with thousand separators manually
    String formattedInteger = _formatWithThousandSeparator(integerPart);
 
    return 'Rp. $formattedInteger,$fractionalPart';
  } catch (_) {
    return _defaultResult();
  }
}
 
String _formatWithThousandSeparator(String s) {
  if (s.isEmpty) return '0';
  String result = '';
  int i = s.length;
  while (i > 0) {
    int start = i - 3 >= 0 ? i - 3 : 0;
    String chunk = s.substring(start, i);
    if (result.isEmpty) {
      result = chunk;
    } else {
      result = '$chunk.$result';
    }
    i -= 3;
  }
  return result;
}
 
String _defaultResult() => 'Rp. 0,00';