import 'dart:convert';

class SPR {
  final String idSite;
  final String siteName;
  final String idCluster;
  final String clusterName;
  final String idHouse;
  final String houseName;
  final String docId;
  final String qcTransId;
  SPR({
    required this.idSite,
    required this.siteName,
    required this.idCluster,
    required this.clusterName,
    required this.idHouse,
    required this.houseName,
    required this.docId,
    required this.qcTransId,
  });

  SPR copyWith({
    String? idSite,
    String? siteName,
    String? idCluster,
    String? clusterName,
    String? idHouse,
    String? houseName,
    String? docId,
    String? qcTransId,
  }) {
    return SPR(
      idSite: idSite ?? this.idSite,
      siteName: siteName ?? this.siteName,
      idCluster: idCluster ?? this.idCluster,
      clusterName: clusterName ?? this.clusterName,
      idHouse: idHouse ?? this.idHouse,
      houseName: houseName ?? this.houseName,
      docId: docId ?? this.docId,
      qcTransId: qcTransId ?? this.qcTransId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_site': idSite,
      'site_name': siteName,
      'id_cluster': idCluster,
      'cluster_name': clusterName,
      'id_house': idHouse,
      'house_name': houseName,
      'doc_id': docId,
      'qc_trans_id': qcTransId,
    };
  }

  factory SPR.fromMap(Map<String, dynamic> map) {
    return SPR(
      idSite: map['id_site'] ?? '',
      siteName: map['site_name'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      idHouse: map['id_house'] ?? '',
      houseName: map['house_name'] ?? '',
      docId: map['doc_id'] ?? '',
      qcTransId: map['qc_trans_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SPR.fromJson(String source) => SPR.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SPR(idSite: $idSite, siteName: $siteName, idCluster: $idCluster, clusterName: $clusterName, idHouse: $idHouse, houseName: $houseName, docId: $docId, qcTransId: $qcTransId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SPR &&
        other.idSite == idSite &&
        other.siteName == siteName &&
        other.idCluster == idCluster &&
        other.clusterName == clusterName &&
        other.idHouse == idHouse &&
        other.houseName == houseName &&
        other.docId == docId &&
        other.qcTransId == qcTransId;
  }

  @override
  int get hashCode {
    return idSite.hashCode ^
        siteName.hashCode ^
        idCluster.hashCode ^
        clusterName.hashCode ^
        idHouse.hashCode ^
        houseName.hashCode ^
        docId.hashCode ^
        qcTransId.hashCode;
  }
}
