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
