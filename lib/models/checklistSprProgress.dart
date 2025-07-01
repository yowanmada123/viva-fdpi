import 'dart:convert';

import '../utils/datetime_convertion.dart';

class ChecklistSprItem {
  final String idQcItem;
  final String itemName;
  final DateTime? dtAprv;
  final DateTime? dtAprv2;
  final DateTime? dtAprv3;
  final String statClosing;
  final String statClosing2;
  final String statClosing3;
  final String imgLink;
  final String imgLink2;
  final String imgLink3;
  ChecklistSprItem({
    required this.idQcItem,
    required this.itemName,
    required this.dtAprv,
    required this.dtAprv2,
    required this.dtAprv3,
    required this.statClosing,
    required this.statClosing2,
    required this.statClosing3,
    required this.imgLink,
    required this.imgLink2,
    required this.imgLink3,
  });

  ChecklistSprItem copyWith({
    String? idQcItem,
    String? itemName,
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
    return ChecklistSprItem(
      idQcItem: idQcItem ?? this.idQcItem,
      itemName: itemName ?? this.itemName,
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

  Map<String, dynamic> toMap() {
    return {
      'id_qc_item': idQcItem,
      'item_name': itemName,
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

  static String _generateUrlImage(String path) {
    if (path.isEmpty) return '';
    return 'https://v2.kencana.org/storage/${path}';
  }

  factory ChecklistSprItem.fromMap(Map<String, dynamic> map) {
    return ChecklistSprItem(
      idQcItem: map['id_qc_item'] ?? '',
      itemName: map['item_name'] ?? '',
      dtAprv: parseDateTime(map['dt_aprv'] ?? ''),
      dtAprv2: parseDateTime(map['dt_aprv2'] ?? ''),
      dtAprv3: parseDateTime(map['dt_aprv3'] ?? ''),
      statClosing: map['stat_closing'] ?? '',
      statClosing2: map['stat_closing2'] ?? '',
      statClosing3: map['stat_closing3'] ?? '',
      imgLink: _generateUrlImage(map['img_link']),
      imgLink2: _generateUrlImage(map['img_link2']),
      imgLink3: _generateUrlImage(map['img_link3']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistSprItem.fromJson(String source) =>
      ChecklistSprItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChecklistSprItem(idQcItem: $idQcItem, itemName: $itemName, dtAprv: $dtAprv, dtAprv2: $dtAprv2, dtAprv3: $dtAprv3, statClosing: $statClosing, statClosing2: $statClosing2, statClosing3: $statClosing3, imgLink: $imgLink, imgLink2: $imgLink2, imgLink3: $imgLink3)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChecklistSprItem &&
        other.idQcItem == idQcItem &&
        other.itemName == itemName &&
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
