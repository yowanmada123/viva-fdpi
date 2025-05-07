import 'package:collection/collection.dart';

Map<K, List<T>> groupItemsBy<T, K>(List<T> items, K Function(T) keySelector) {
  return groupBy(items, keySelector);
}
