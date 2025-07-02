import 'dart:convert';

class VendorSpk {
  final String idSpk;
  final String vendorId;
  final String vendorName;
  final String idSite;
  final String siteName;
  final String idCluster;
  final String clusterName;
  final String idHouseUnit;
  final String houseName;
  final String activeFlag;
  final String status;
  final String idCetak;
  final String idSpb;
  final String amt;
  final String amtInclude;
  final String amtExclude;
  final String spkType;
  final String creditLimit;
  final String wSpkType;
  VendorSpk({
    required this.idSpk,
    required this.vendorId,
    required this.vendorName,
    required this.idSite,
    required this.siteName,
    required this.idCluster,
    required this.clusterName,
    required this.idHouseUnit,
    required this.houseName,
    required this.activeFlag,
    required this.status,
    required this.idCetak,
    required this.idSpb,
    required this.amt,
    required this.amtInclude,
    required this.amtExclude,
    required this.spkType,
    required this.creditLimit,
    required this.wSpkType,
  });

  VendorSpk copyWith({
    String? idSpk,
    String? vendorId,
    String? vendorName,
    String? idSite,
    String? siteName,
    String? idCluster,
    String? clusterName,
    String? idHouseUnit,
    String? houseName,
    String? activeFlag,
    String? status,
    String? idCetak,
    String? idSpb,
    String? amt,
    String? amtInclude,
    String? amtExclude,
    String? spkType,
    String? creditLimit,
    String? wSpkType,
  }) {
    return VendorSpk(
      idSpk: idSpk ?? this.idSpk,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      idSite: idSite ?? this.idSite,
      siteName: siteName ?? this.siteName,
      idCluster: idCluster ?? this.idCluster,
      clusterName: clusterName ?? this.clusterName,
      idHouseUnit: idHouseUnit ?? this.idHouseUnit,
      houseName: houseName ?? this.houseName,
      activeFlag: activeFlag ?? this.activeFlag,
      status: status ?? this.status,
      idCetak: idCetak ?? this.idCetak,
      idSpb: idSpb ?? this.idSpb,
      amt: amt ?? this.amt,
      amtInclude: amtInclude ?? this.amtInclude,
      amtExclude: amtExclude ?? this.amtExclude,
      spkType: spkType ?? this.spkType,
      creditLimit: creditLimit ?? this.creditLimit,
      wSpkType: wSpkType ?? this.wSpkType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_spk': idSpk,
      'vendor_id': vendorId,
      'vendor_name': vendorName,
      'id_site': idSite,
      'site_name': siteName,
      'id_cluster': idCluster,
      'cluster_name': clusterName,
      'id_house_unit': idHouseUnit,
      'house_name': houseName,
      'active_flag': activeFlag,
      'status': status,
      'id_cetak': idCetak,
      'id_spb': idSpb,
      'amt': amt,
      'amt_include': amtInclude,
      'amt_exclude': amtExclude,
      'spk_type': spkType,
      'credit_limit': creditLimit,
      'w_spk_type': wSpkType,
    };
  }

  factory VendorSpk.fromMap(Map<String, dynamic> map) {
    return VendorSpk(
      idSpk: map['id_spk'] ?? '',
      vendorId: map['vendor_id'] ?? '',
      vendorName: map['vendor_name'] ?? '',
      idSite: map['id_site'] ?? '',
      siteName: map['site_name'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      idHouseUnit: map['id_house_unit'] ?? '',
      houseName: map['house_name'] ?? '',
      activeFlag: map['active_flag'] ?? '',
      status: map['status'] ?? '',
      idCetak: map['id_cetak'] ?? '',
      idSpb: map['id_spb'] ?? '',
      amt: map['amt'] ?? '',
      amtInclude: map['amt_include'] ?? '',
      amtExclude: map['amt_exclude'] ?? '',
      spkType: map['spk_type'] ?? '',
      creditLimit: map['credit_limit'] ?? '',
      wSpkType: map['w_spk_type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorSpk.fromJson(String source) =>
      VendorSpk.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VendorSpk(idSpk: $idSpk, vendorId: $vendorId, vendorName: $vendorName, idSite: $idSite, siteName: $siteName, idCluster: $idCluster, clusterName: $clusterName, idHouseUnit: $idHouseUnit, houseName: $houseName, activeFlag: $activeFlag, status: $status, idCetak: $idCetak, idSpb: $idSpb, amt: $amt, amtInclude: $amtInclude, amtExclude: $amtExclude, spkType: $spkType, creditLimit: $creditLimit, wSpkType: $wSpkType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VendorSpk &&
        other.idSpk == idSpk &&
        other.vendorId == vendorId &&
        other.vendorName == vendorName &&
        other.idSite == idSite &&
        other.siteName == siteName &&
        other.idCluster == idCluster &&
        other.clusterName == clusterName &&
        other.idHouseUnit == idHouseUnit &&
        other.houseName == houseName &&
        other.activeFlag == activeFlag &&
        other.status == status &&
        other.idCetak == idCetak &&
        other.idSpb == idSpb &&
        other.amt == amt &&
        other.amtInclude == amtInclude &&
        other.amtExclude == amtExclude &&
        other.spkType == spkType &&
        other.creditLimit == creditLimit &&
        other.wSpkType == wSpkType;
  }

  @override
  int get hashCode {
    return idSpk.hashCode ^
        vendorId.hashCode ^
        vendorName.hashCode ^
        idSite.hashCode ^
        siteName.hashCode ^
        idCluster.hashCode ^
        clusterName.hashCode ^
        idHouseUnit.hashCode ^
        houseName.hashCode ^
        activeFlag.hashCode ^
        status.hashCode ^
        idCetak.hashCode ^
        idSpb.hashCode ^
        amt.hashCode ^
        amtInclude.hashCode ^
        amtExclude.hashCode ^
        spkType.hashCode ^
        creditLimit.hashCode ^
        wSpkType.hashCode;
  }
}
