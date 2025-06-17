import 'dart:convert';

class Spb {
  final String idSpb;
  final String remark;
  final String dtAprv1;
  final String aprv1By;
  final String dtAprv2;
  final String aprv2By;
  final String dtReject;
  final String rejectBy;
  final String dtReject2;
  final String reject2By;
  final String siteName;
  final String clusterName;
  final String remarkCluster;
  final String houseName;
  final String commonName;
  final String sbkName;
  final String category;
  Spb({
    required this.idSpb,
    required this.remark,
    required this.dtAprv1,
    required this.aprv1By,
    required this.dtAprv2,
    required this.aprv2By,
    required this.dtReject,
    required this.rejectBy,
    required this.dtReject2,
    required this.reject2By,
    required this.siteName,
    required this.clusterName,
    required this.remarkCluster,
    required this.houseName,
    required this.commonName,
    required this.sbkName,
    required this.category,
  });

  Spb copyWith({
    String? idSpb,
    String? remark,
    String? dtAprv1,
    String? aprv1By,
    String? dtAprv2,
    String? aprv2By,
    String? dtReject,
    String? rejectBy,
    String? dtReject2,
    String? reject2By,
    String? siteName,
    String? clusterName,
    String? remarkCluster,
    String? houseName,
    String? commonName,
    String? sbkName,
    String? category,
  }) {
    return Spb(
      idSpb: idSpb ?? this.idSpb,
      remark: remark ?? this.remark,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      aprv1By: aprv1By ?? this.aprv1By,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      aprv2By: aprv2By ?? this.aprv2By,
      dtReject: dtReject ?? this.dtReject,
      rejectBy: rejectBy ?? this.rejectBy,
      dtReject2: dtReject2 ?? this.dtReject2,
      reject2By: reject2By ?? this.reject2By,
      siteName: siteName ?? this.siteName,
      clusterName: clusterName ?? this.clusterName,
      remarkCluster: remarkCluster ?? this.remarkCluster,
      houseName: houseName ?? this.houseName,
      commonName: commonName ?? this.commonName,
      sbkName: sbkName ?? this.sbkName,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_spb': idSpb,
      'remark': remark,
      'dt_aprv1': dtAprv1,
      'aprv1_by': aprv1By,
      'dt_aprv2': dtAprv2,
      'aprv2_by': aprv2By,
      'dt_reject': dtReject,
      'reject_by': rejectBy,
      'dt_reject2': dtReject2,
      'reject2_by': reject2By,
      'site_name': siteName,
      'cluster_name': clusterName,
      'remark_cluster': remarkCluster,
      'house_name': houseName,
      'common_name': commonName,
      'sbk_name': sbkName,
      'category': category,
    };
  }

  factory Spb.fromMap(Map<String, dynamic> map) {
    return Spb(
      idSpb: map['id_spb'] ?? '',
      remark: map['remark'] ?? '',
      dtAprv1: map['dt_aprv1'] ?? '',
      aprv1By: map['aprv1_by'] ?? '',
      dtAprv2: map['dt_aprv2'] ?? '',
      aprv2By: map['aprv2_by'] ?? '',
      dtReject: map['dt_reject'] ?? '',
      rejectBy: map['reject_by'] ?? '',
      dtReject2: map['dt_reject2'] ?? '',
      reject2By: map['reject2_by'] ?? '',
      siteName: map['site_name'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      remarkCluster: map['remark_cluster'] ?? '',
      houseName: map['house_name'] ?? '',
      commonName: map['common_name'] ?? '',
      sbkName: map['sbk_name'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Spb.fromJson(String source) => Spb.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Spb(idSpb: $idSpb, remark: $remark, dtAprv1: $dtAprv1, aprv1By: $aprv1By, dtAprv2: $dtAprv2, aprv2By: $aprv2By, dtReject: $dtReject, rejectBy: $rejectBy, dtReject2: $dtReject2, reject2By: $reject2By, siteName: $siteName, clusterName: $clusterName, remarkCluster: $remarkCluster, houseName: $houseName, commonName: $commonName, sbkName: $sbkName, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Spb &&
        other.idSpb == idSpb &&
        other.remark == remark &&
        other.dtAprv1 == dtAprv1 &&
        other.aprv1By == aprv1By &&
        other.dtAprv2 == dtAprv2 &&
        other.aprv2By == aprv2By &&
        other.dtReject == dtReject &&
        other.rejectBy == rejectBy &&
        other.dtReject2 == dtReject2 &&
        other.reject2By == reject2By &&
        other.siteName == siteName &&
        other.clusterName == clusterName &&
        other.remarkCluster == remarkCluster &&
        other.houseName == houseName &&
        other.commonName == commonName &&
        other.sbkName == sbkName &&
        other.category == category;
  }

  @override
  int get hashCode {
    return idSpb.hashCode ^
        remark.hashCode ^
        dtAprv1.hashCode ^
        aprv1By.hashCode ^
        dtAprv2.hashCode ^
        aprv2By.hashCode ^
        dtReject.hashCode ^
        rejectBy.hashCode ^
        dtReject2.hashCode ^
        reject2By.hashCode ^
        siteName.hashCode ^
        clusterName.hashCode ^
        remarkCluster.hashCode ^
        houseName.hashCode ^
        commonName.hashCode ^
        sbkName.hashCode ^
        category.hashCode;
  }
}
