import 'dart:convert';

class SPKGroupedByClusterHome {
  final String idCluster;
  final String clusterName;
  final String idHouse;
  final String houseName;
  final List<SPK> spks;

  SPKGroupedByClusterHome({
    required this.idCluster,
    required this.clusterName,
    required this.idHouse,
    required this.houseName,
    required this.spks,
  });
}

class SPK {
  final String idSite;
  final String siteName;
  final String idCluster;
  final String clusterName;
  final String idHouse;
  final String houseName;
  final String idSPK;
  final String pihak2;
  final String vendorName;
  final String qcTransId;
  final String spkType;
  final String spkLabel;

  SPK({
    required this.idSite,
    required this.siteName,
    required this.idCluster,
    required this.clusterName,
    required this.idHouse,
    required this.houseName,
    required this.idSPK,
    required this.pihak2,
    required this.vendorName,
    required this.qcTransId,
    required this.spkType,
    required this.spkLabel,
  });

  SPK copyWith({
    String? idSite,
    String? siteName,
    String? idCluster,
    String? clusterName,
    String? idHouse,
    String? houseName,
    String? idSPK,
    String? pihak2,
    String? vendorName,
    String? qcTransId,
    String? spkType,
    String? spkLabel,
  }) {
    return SPK(
      idSite: idSite ?? this.idSite,
      siteName: siteName ?? this.siteName,
      idCluster: idCluster ?? this.idCluster,
      clusterName: clusterName ?? this.clusterName,
      idHouse: idHouse ?? this.idHouse,
      houseName: houseName ?? this.houseName,
      idSPK: idSPK ?? this.idSPK,
      pihak2: pihak2 ?? this.pihak2,
      vendorName: vendorName ?? this.vendorName,
      qcTransId: qcTransId ?? this.qcTransId,
      spkType: spkType ?? this.spkType,
      spkLabel: spkLabel ?? this.spkLabel,
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
      'id_spk': idSPK,
      'pihak_2': pihak2,
      'vendor_name': vendorName,
      'qc_trans_id': qcTransId,
      'spk_type': spkType,
      'spk_label': spkLabel,
    };
  }

  factory SPK.fromMap(Map<String, dynamic> map) {
    return SPK(
      idSite: map['id_site'] ?? '',
      siteName: map['site_name'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      idHouse: map['id_house'] ?? '',
      houseName: map['house_name'] ?? '',
      idSPK: map['id_spk'] ?? '',
      pihak2: map['pihak_2'] ?? '',
      vendorName: map['vendor_name'] ?? '',
      qcTransId: map['qc_trans_id'] ?? '',
      spkType: map['spk_type'] ?? '',
      spkLabel: map['spk_label'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SPK.fromJson(String source) => SPK.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SPK(idSite: $idSite, siteName: $siteName, idCluster: $idCluster, clusterName: $clusterName, idHouse: $idHouse, houseName: $houseName, idSPK: $idSPK, pihak2: $pihak2, vendorName: $vendorName, qcTransId: $qcTransId, spkType: $spkType, spkLabel: $spkLabel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SPK &&
        other.idSite == idSite &&
        other.siteName == siteName &&
        other.idCluster == idCluster &&
        other.clusterName == clusterName &&
        other.idHouse == idHouse &&
        other.houseName == houseName &&
        other.idSPK == idSPK &&
        other.pihak2 == pihak2 &&
        other.vendorName == vendorName &&
        other.qcTransId == qcTransId &&
        other.spkType == spkType &&
        other.spkLabel == spkLabel;
  }

  @override
  int get hashCode {
    return idSite.hashCode ^
        siteName.hashCode ^
        idCluster.hashCode ^
        clusterName.hashCode ^
        idHouse.hashCode ^
        houseName.hashCode ^
        idSPK.hashCode ^
        pihak2.hashCode ^
        vendorName.hashCode ^
        qcTransId.hashCode ^
        spkType.hashCode ^
        spkLabel.hashCode;
  }
}
