import 'package:intl/intl.dart';

DateTime? parseDateTime(String dateTimeString) {
  try {
    if (dateTimeString.isEmpty) return null;

    if (dateTimeString.contains('1900-01-01 00:00:00')) {
      return null;
    }

    return DateTime.tryParse(dateTimeString);
  } catch (e) {
    return null;
  }
}

String formatDateTime(String? date) {
  if (date == null || date.trim().isEmpty) return '-';

  try {
    final parsedDate = DateTime.parse(date);

    // handle default SQL date
    if (parsedDate.year == 1900) return '-';

    final formatter = DateFormat('dd MMM yyyy, HH:mm', 'id_ID');

    return formatter.format(parsedDate);
  } catch (e) {
    return '-';
  }
}

DateTime stringToDateTime(String date) {
  final format = DateFormat("yyyy-MM-dd HH:mm:ss.SSS");
  return format.parse(date);
}
