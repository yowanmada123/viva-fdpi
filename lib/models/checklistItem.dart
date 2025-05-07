import 'dart:convert';

class ChecklistItem {
  final String qcTransId;
  final String idQcItem;
  final String qcItem;
  final String stat;
  final String comId;
  final String comDesc;
  final String clusterName;
  final String siteName;
  final String houseName;
  final String dtAprv;
  final String aprvBy;
  ChecklistItem({
    required this.qcTransId,
    required this.idQcItem,
    required this.qcItem,
    required this.stat,
    required this.comId,
    required this.comDesc,
    required this.clusterName,
    required this.siteName,
    required this.houseName,
    required this.dtAprv,
    required this.aprvBy,
  });

  ChecklistItem copyWith({
    String? qcTransId,
    String? idQcItem,
    String? qcItem,
    String? stat,
    String? comId,
    String? comDesc,
    String? clusterName,
    String? siteName,
    String? houseName,
    String? dtAprv,
    String? aprvBy,
  }) {
    return ChecklistItem(
      qcTransId: qcTransId ?? this.qcTransId,
      idQcItem: idQcItem ?? this.idQcItem,
      qcItem: qcItem ?? this.qcItem,
      stat: stat ?? this.stat,
      comId: comId ?? this.comId,
      comDesc: comDesc ?? this.comDesc,
      clusterName: clusterName ?? this.clusterName,
      siteName: siteName ?? this.siteName,
      houseName: houseName ?? this.houseName,
      dtAprv: dtAprv ?? this.dtAprv,
      aprvBy: aprvBy ?? this.aprvBy,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'qc_trans_id': qcTransId,
      'id_qc_item': idQcItem,
      'qc_item': qcItem,
      'stat': stat,
      'com_id': comId,
      'com_desc': comDesc,
      'cluster_name': clusterName,
      'site_name': siteName,
      'house_name': houseName,
      'dt_aprv': dtAprv,
      'aprv_by': aprvBy,
    };
  }

  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    return ChecklistItem(
      qcTransId: map['qc_trans_id'] ?? '',
      idQcItem: map['id_qc_item'] ?? '',
      qcItem: map['qc_item'] ?? '',
      stat: map['stat'] ?? '',
      comId: map['com_id'] ?? '',
      comDesc: map['com_desc'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      siteName: map['site_name'] ?? '',
      houseName: map['house_name'] ?? '',
      dtAprv: map['dt_aprv'] ?? '',
      aprvBy: map['aprv_by'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistItem.fromJson(String source) =>
      ChecklistItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChecklistItem(qcTransId: $qcTransId, idQcItem: $idQcItem, qcItem: $qcItem, stat: $stat, comId: $comId, comDesc: $comDesc, clusterName: $clusterName, siteName: $siteName, houseName: $houseName, dtAprv: $dtAprv, aprvBy: $aprvBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChecklistItem &&
        other.qcTransId == qcTransId &&
        other.idQcItem == idQcItem &&
        other.qcItem == qcItem &&
        other.stat == stat &&
        other.comId == comId &&
        other.comDesc == comDesc &&
        other.clusterName == clusterName &&
        other.siteName == siteName &&
        other.houseName == houseName &&
        other.dtAprv == dtAprv &&
        other.aprvBy == aprvBy;
  }

  @override
  int get hashCode {
    return qcTransId.hashCode ^
        idQcItem.hashCode ^
        qcItem.hashCode ^
        stat.hashCode ^
        comId.hashCode ^
        comDesc.hashCode ^
        clusterName.hashCode ^
        siteName.hashCode ^
        houseName.hashCode ^
        dtAprv.hashCode ^
        aprvBy.hashCode;
  }
}
