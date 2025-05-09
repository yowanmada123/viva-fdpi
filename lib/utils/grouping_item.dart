import 'package:collection/collection.dart';

Map<K, List<T>> groupItemsBy<T, K>(List<T> items, K Function(T) keySelector) {
  return groupBy(items, keySelector);
}

Map<K, Map<String, dynamic>> groupItemsWithStats<T, K>({
  required List<T> items,
  required K Function(T) keySelector,
  required bool Function(T) isApproved,
  bool Function(int approvedCount, int totalCount)? isComplete,
}) {
  final result = <K, Map<String, dynamic>>{};

  for (final item in items) {
    final key = keySelector(item);

    // Initialize group if not exists
    result.putIfAbsent(
      key,
      () => {
        'data': <T>[],
        'approve_count': 0,
        'data_item': 0,
        'finish': false,
      },
    );

    // Add item to group data
    result[key]!['data'].add(item);
    result[key]!['data_item'] += 1;

    // Update approval count if applicable
    if (isApproved(item)) {
      result[key]!['approve_count'] += 1;
    }

    // Update finish status (default: all must be approved)
    final completeChecker =
        isComplete ?? (approved, total) => approved == total;
    result[key]!['finish'] = completeChecker(
      result[key]!['approve_count'],
      result[key]!['data_item'],
    );
  }

  return result;
}
