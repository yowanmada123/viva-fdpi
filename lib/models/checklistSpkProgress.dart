import 'dart:convert';

import '../utils/datetime_convertion.dart';

class ChecklistSpkProgress {
  final int comId;
  final String comDesc;
  final List<ChecklistCategory> checklistCategories; // Equivalent to data
  ChecklistSpkProgress({
    required this.comId,
    required this.comDesc,
    required this.checklistCategories,
  });

  ChecklistSpkProgress copyWith({
    int? comId,
    String? comDesc,
    List<ChecklistCategory>? checklistCategories,
  }) {
    return ChecklistSpkProgress(
      comId: comId ?? this.comId,
      comDesc: comDesc ?? this.comDesc,
      checklistCategories: checklistCategories ?? this.checklistCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'com_id': comId,
      'com_desc': comDesc,
      'checklistCategories': checklistCategories,
    };
  }

  factory ChecklistSpkProgress.fromMap(Map<String, dynamic> data) {
    return ChecklistSpkProgress(
      comId: data['com_id'] ?? "",
      comDesc: data['com_desc'] ?? '',
      checklistCategories:
          (data['categories'] as List<dynamic>).map((e) {
            return ChecklistCategory.fromMap(e as Map<String, dynamic>);
          }).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistSpkProgress.fromJson(String source) =>
      ChecklistSpkProgress.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChecklistSpkProgress(comId: $comId, comDesc: $comDesc, checklistCategories: $checklistCategories)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChecklistSpkProgress &&
        other.comId == comId &&
        other.comDesc == comDesc &&
        other.checklistCategories == checklistCategories;
  }

  @override
  int get hashCode =>
      comId.hashCode ^ comDesc.hashCode ^ checklistCategories.hashCode;
}

// ChecklistCategory
class ChecklistCategory {
  final int catId;
  final String catName;
  final List<ChecklistSpkItem> checklistItems;
  ChecklistCategory({
    required this.catId,
    required this.catName,
    required this.checklistItems,
  });

  ChecklistCategory copyWith({
    int? catId,
    String? catName,
    List<ChecklistSpkItem>? checklistItems,
  }) {
    return ChecklistCategory(
      catId: catId ?? this.catId,
      catName: catName ?? this.catName,
      checklistItems: checklistItems ?? this.checklistItems,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cat_id': catId,
      'cat_name': catName,
      'checklist_items': checklistItems,
    };
  }

  factory ChecklistCategory.fromMap(Map<String, dynamic> data) {
    return ChecklistCategory(
      catId: data['cat_id'],
      catName: data['cat_name'] ?? '',
      checklistItems:
          (data['items'] as List).map((e) {
            return ChecklistSpkItem.fromMap(e);
          }).toList(), // ← Add .toList() here
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistCategory.fromJson(String source) =>
      ChecklistCategory.fromMap(json.decode(source));

  @override
  String toString() =>
      'ChecklistCategory(catId: $catId, catName: $catName, checklistItems: $checklistItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChecklistCategory &&
        other.catId == catId &&
        other.catName == catName &&
        other.checklistItems == checklistItems;
  }

  @override
  int get hashCode =>
      catId.hashCode ^ catName.hashCode ^ checklistItems.hashCode;
}

// Checklist Item
class ChecklistSpkItem {
  final String idQcItem;
  final String itemName;
  final String catId;
  final String catName;
  final DateTime? dtAprv;
  final DateTime? dtAprv2;
  final DateTime? dtAprv3;
  final String statClosing;
  final String statClosing2;
  final String statClosing3;
  final String imgLink;
  final String imgLink2;
  final String imgLink3;
  ChecklistSpkItem({
    required this.idQcItem,
    required this.itemName,
    required this.catId,
    required this.catName,
    this.dtAprv,
    this.dtAprv2,
    this.dtAprv3,
    required this.statClosing,
    required this.statClosing2,
    required this.statClosing3,
    required this.imgLink,
    required this.imgLink2,
    required this.imgLink3,
  });

  ChecklistSpkItem copyWith({
    String? idQcItem,
    String? itemName,
    String? catId,
    String? catName,
    DateTime? dtAprv,
    DateTime? dtAprv2,
    DateTime? dtAprv3,
    String? statClosing,
    String? statClosing2,
    String? statClosing3,
    String? imgLink,
    String? imgLink2,
    String? imgLink3,
  }) {
    return ChecklistSpkItem(
      idQcItem: idQcItem ?? this.idQcItem,
      itemName: itemName ?? this.itemName,
      catId: catId ?? this.catId,
      catName: catName ?? this.catName,
      dtAprv: dtAprv ?? this.dtAprv,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      dtAprv3: dtAprv3 ?? this.dtAprv3,
      statClosing: statClosing ?? this.statClosing,
      statClosing2: statClosing2 ?? this.statClosing2,
      statClosing3: statClosing3 ?? this.statClosing3,
      imgLink: imgLink ?? this.imgLink,
      imgLink2: imgLink2 ?? this.imgLink2,
      imgLink3: imgLink3 ?? this.imgLink3,
    );
  }

  static String _generateUrlImage(String path) {
    if (path.isEmpty) return '';
    return 'https://v2.kencana.org/storage/${path}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id_qc_item': idQcItem,
      'item_name': itemName,
      'cat_id': catId,
      'cat_name': catName,
      'dt_aprv': dtAprv,
      'dt_aprv2': dtAprv2,
      'dt_aprv3': dtAprv3,
      'stat_closing': statClosing,
      'stat_closing2': statClosing2,
      'stat_closing3': statClosing3,
      'img_link': imgLink,
      'img_link2': imgLink2,
      'img_link3': imgLink3,
    };
  }

  factory ChecklistSpkItem.fromMap(Map<String, dynamic> map) {
    return ChecklistSpkItem(
      idQcItem: map['id_qc_item'] ?? '',
      itemName: map['item_name'] ?? '',
      catId: map['cat_id'] ?? '',
      catName: map['cat_name'] ?? '',
      dtAprv: parseDateTime(map['dt_aprv']),
      dtAprv2: parseDateTime(map['dt_aprv2']),
      dtAprv3: parseDateTime(map['dt_aprv3']),
      statClosing: map['stat_closing'] ?? '',
      statClosing2: map['stat_closing2'] ?? '',
      statClosing3: map['stat_closing3'] ?? '',
      imgLink: _generateUrlImage(map['img_link']),
      imgLink2: _generateUrlImage(map['img_link2']),
      imgLink3: _generateUrlImage(map['img_link3']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistSpkItem.fromJson(String source) =>
      ChecklistSpkItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChecklistSpkItem(idQcItem: $idQcItem, itemName: $itemName, catId: $catId, catName: $catName, dtAprv: $dtAprv, dtAprv2: $dtAprv2, dtAprv3: $dtAprv3, statClosing: $statClosing, statClosing2: $statClosing2, statClosing3: $statClosing3, imgLink: $imgLink, imgLink2: $imgLink2, imgLink3: $imgLink3)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChecklistSpkItem &&
        other.idQcItem == idQcItem &&
        other.itemName == itemName &&
        other.catId == catId &&
        other.catName == catName &&
        other.dtAprv == dtAprv &&
        other.dtAprv2 == dtAprv2 &&
        other.dtAprv3 == dtAprv3 &&
        other.statClosing == statClosing &&
        other.statClosing2 == statClosing2 &&
        other.statClosing3 == statClosing3 &&
        other.imgLink == imgLink &&
        other.imgLink2 == imgLink2 &&
        other.imgLink3 == imgLink3;
  }

  @override
  int get hashCode {
    return idQcItem.hashCode ^
        itemName.hashCode ^
        catId.hashCode ^
        catName.hashCode ^
        dtAprv.hashCode ^
        dtAprv2.hashCode ^
        dtAprv3.hashCode ^
        statClosing.hashCode ^
        statClosing2.hashCode ^
        statClosing3.hashCode ^
        imgLink.hashCode ^
        imgLink2.hashCode ^
        imgLink3.hashCode;
  }
}
