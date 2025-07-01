import 'dart:convert';

import '../../utils/datetime_convertion.dart';

class ApprovalSpbDetail {
  final String docType;
  final String docId;
  final String docCat;
  final String wDocCat;
  final String idSite;
  final String idCluster;
  final String idHouse;
  final String siteName;
  final String clusterName;
  final String houseName;
  final DateTime? dtCreated;
  final String createdBy;
  final DateTime? dtAprv1;
  final String aprv1By;
  final DateTime? dtAprv2;
  final String aprv2By;
  final String dtReject;
  final String rejectBy;
  final String dtReject2;
  final String reject2By;
  final String status;
  final String wCreatedBy;
  final String wAprv1By;
  final String wAprv2By;
  final String wReject1By;
  final String wReject2By;
  ApprovalSpbDetail({
    required this.docType,
    required this.docId,
    required this.docCat,
    required this.wDocCat,
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
    required this.siteName,
    required this.clusterName,
    required this.houseName,
    required this.dtCreated,
    required this.createdBy,
    required this.dtAprv1,
    required this.aprv1By,
    required this.dtAprv2,
    required this.aprv2By,
    required this.dtReject,
    required this.rejectBy,
    required this.dtReject2,
    required this.reject2By,
    required this.status,
    required this.wCreatedBy,
    required this.wAprv1By,
    required this.wAprv2By,
    required this.wReject1By,
    required this.wReject2By,
  });

  ApprovalSpbDetail copyWith({
    String? docType,
    String? docId,
    String? docCat,
    String? wDocCat,
    String? idSite,
    String? idCluster,
    String? idHouse,
    String? siteName,
    String? clusterName,
    String? houseName,
    DateTime? dtCreated,
    String? createdBy,
    DateTime? dtAprv1,
    String? aprv1By,
    DateTime? dtAprv2,
    String? aprv2By,
    String? dtReject,
    String? rejectBy,
    String? dtReject2,
    String? reject2By,
    String? status,
    String? wCreatedBy,
    String? wAprv1By,
    String? wAprv2By,
    String? wReject1By,
    String? wReject2By,
  }) {
    return ApprovalSpbDetail(
      docType: docType ?? this.docType,
      docId: docId ?? this.docId,
      docCat: docCat ?? this.docCat,
      wDocCat: wDocCat ?? this.wDocCat,
      idSite: idSite ?? this.idSite,
      idCluster: idCluster ?? this.idCluster,
      idHouse: idHouse ?? this.idHouse,
      siteName: siteName ?? this.siteName,
      clusterName: clusterName ?? this.clusterName,
      houseName: houseName ?? this.houseName,
      dtCreated: dtCreated ?? this.dtCreated,
      createdBy: createdBy ?? this.createdBy,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      aprv1By: aprv1By ?? this.aprv1By,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      aprv2By: aprv2By ?? this.aprv2By,
      dtReject: dtReject ?? this.dtReject,
      rejectBy: rejectBy ?? this.rejectBy,
      dtReject2: dtReject2 ?? this.dtReject2,
      reject2By: reject2By ?? this.reject2By,
      status: status ?? this.status,
      wCreatedBy: wCreatedBy ?? this.wCreatedBy,
      wAprv1By: wAprv1By ?? this.wAprv1By,
      wAprv2By: wAprv2By ?? this.wAprv2By,
      wReject1By: wReject1By ?? this.wReject1By,
      wReject2By: wReject2By ?? this.wReject2By,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doc_type': docType,
      'doc_id': docId,
      'doc_cat': docCat,
      'w_doc_cat': wDocCat,
      'id_site': idSite,
      'id_cluster': idCluster,
      'id_house': idHouse,
      'site_name': siteName,
      'cluster_name': clusterName,
      'house_name': houseName,
      'dt_created': dtCreated,
      'created_by': createdBy,
      'dt_aprv1': dtAprv1,
      'aprv1_by': aprv1By,
      'dt_aprv2': dtAprv2,
      'aprv2_by': aprv2By,
      'dt_reject': dtReject,
      'reject_by': rejectBy,
      'dt_reject2': dtReject2,
      'reject2_by': reject2By,
      'status': status,
      'w_created_by': wCreatedBy,
      'w_aprv1_by': wAprv1By,
      'w_aprv2_by': wAprv2By,
      'w_reject1_by': wReject1By,
      'w_reject2_by': wReject2By,
    };
  }

  factory ApprovalSpbDetail.fromMap(Map<String, dynamic> map) {
    return ApprovalSpbDetail(
      docType: map['doc_type'] ?? '',
      docId: map['doc_id'] ?? '',
      docCat: map['doc_cat'] ?? '',
      wDocCat: map['w_doc_cat'] ?? '',
      idSite: map['id_site'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      idHouse: map['id_house'] ?? '',
      siteName: map['site_name'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      houseName: map['house_name'] ?? '',
      dtCreated: parseDateTime(map['dt_created'] ?? ''),
      createdBy: map['created_by'] ?? '',
      dtAprv1: parseDateTime(map['dt_aprv1'] ?? ''),
      aprv1By: map['aprv1_by'] ?? '',
      dtAprv2: parseDateTime(map['dt_aprv2'] ?? ''),
      aprv2By: map['aprv2_by'] ?? '',
      dtReject: map['dt_reject'] ?? '',
      rejectBy: map['reject_by'] ?? '',
      dtReject2: map['dt_reject2'] ?? '',
      reject2By: map['reject2_by'] ?? '',
      status: map['status'] ?? '',
      wCreatedBy: map['w_created_by'] ?? '',
      wAprv1By: map['w_aprv1_by'] ?? '',
      wAprv2By: map['w_aprv2_by'] ?? '',
      wReject1By: map['w_reject1_by'] ?? '',
      wReject2By: map['w_reject2_by'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalSpbDetail.fromJson(String source) =>
      ApprovalSpbDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalSpbDetail(docType: $docType, docId: $docId, docCat: $docCat, wDocCat: $wDocCat, idSite: $idSite, idCluster: $idCluster, idHouse: $idHouse, siteName: $siteName, clusterName: $clusterName, houseName: $houseName, dtCreated: $dtCreated, createdBy: $createdBy, dtAprv1: $dtAprv1, aprv1By: $aprv1By, dtAprv2: $dtAprv2, aprv2By: $aprv2By, dtReject: $dtReject, rejectBy: $rejectBy, dtReject2: $dtReject2, reject2By: $reject2By, status: $status, wCreatedBy: $wCreatedBy, wAprv1By: $wAprv1By, wAprv2By: $wAprv2By, wReject1By: $wReject1By, wReject2By: $wReject2By)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalSpbDetail &&
        other.docType == docType &&
        other.docId == docId &&
        other.docCat == docCat &&
        other.wDocCat == wDocCat &&
        other.idSite == idSite &&
        other.idCluster == idCluster &&
        other.idHouse == idHouse &&
        other.siteName == siteName &&
        other.clusterName == clusterName &&
        other.houseName == houseName &&
        other.dtCreated == dtCreated &&
        other.createdBy == createdBy &&
        other.dtAprv1 == dtAprv1 &&
        other.aprv1By == aprv1By &&
        other.dtAprv2 == dtAprv2 &&
        other.aprv2By == aprv2By &&
        other.dtReject == dtReject &&
        other.rejectBy == rejectBy &&
        other.dtReject2 == dtReject2 &&
        other.reject2By == reject2By &&
        other.status == status &&
        other.wCreatedBy == wCreatedBy &&
        other.wAprv1By == wAprv1By &&
        other.wAprv2By == wAprv2By &&
        other.wReject1By == wReject1By &&
        other.wReject2By == wReject2By;
  }

  @override
  int get hashCode {
    return docType.hashCode ^
        docId.hashCode ^
        docCat.hashCode ^
        wDocCat.hashCode ^
        idSite.hashCode ^
        idCluster.hashCode ^
        idHouse.hashCode ^
        siteName.hashCode ^
        clusterName.hashCode ^
        houseName.hashCode ^
        dtCreated.hashCode ^
        createdBy.hashCode ^
        dtAprv1.hashCode ^
        aprv1By.hashCode ^
        dtAprv2.hashCode ^
        aprv2By.hashCode ^
        dtReject.hashCode ^
        rejectBy.hashCode ^
        dtReject2.hashCode ^
        reject2By.hashCode ^
        status.hashCode ^
        wCreatedBy.hashCode ^
        wAprv1By.hashCode ^
        wAprv2By.hashCode ^
        wReject1By.hashCode ^
        wReject2By.hashCode;
  }
}
