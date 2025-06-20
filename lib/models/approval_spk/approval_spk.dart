import 'dart:convert';

import 'approval_spk_article.dart';

class ApprovalSpk {
  final String idSpk;
  final String spkType;
  final String dtReject;
  final String rejectBy;
  final String dtReject2;
  final String reject2By;
  final String siteName;
  final String remark;
  final String clusterName;
  final String remarkCluster;
  final String houseName;
  final String commonName;
  final String sbkName;
  final String category;
  final String namaContractor;
  final String namaEmployee;
  final String jabatanEmployee;
  final String alamatEmployee;
  final String idQcForm;
  final String qcTransId;
  final String harga;
  final String wCreatedBy;
  final String wAprv1By;
  final String wAprv2By;
  final String wReject1By;
  final String wReject2By;
  final String remarkQc;
  final String remarks;
  final String dtAprv1;
  final String aprv1By;
  final String dtAprv2;
  final String aprv2By;
  final List<ApprovalSpkArticle> article;
  ApprovalSpk({
    required this.idSpk,
    required this.spkType,
    required this.dtReject,
    required this.rejectBy,
    required this.dtReject2,
    required this.reject2By,
    required this.siteName,
    required this.remark,
    required this.clusterName,
    required this.remarkCluster,
    required this.houseName,
    required this.commonName,
    required this.sbkName,
    required this.category,
    required this.namaContractor,
    required this.namaEmployee,
    required this.jabatanEmployee,
    required this.alamatEmployee,
    required this.idQcForm,
    required this.qcTransId,
    required this.harga,
    required this.wCreatedBy,
    required this.wAprv1By,
    required this.wAprv2By,
    required this.wReject1By,
    required this.wReject2By,
    required this.remarkQc,
    required this.remarks,
    required this.dtAprv1,
    required this.aprv1By,
    required this.dtAprv2,
    required this.aprv2By,
    required this.article,
  });

  ApprovalSpk copyWith({
    String? idSpk,
    String? spkType,
    String? dtReject,
    String? rejectBy,
    String? dtReject2,
    String? reject2By,
    String? siteName,
    String? remark,
    String? clusterName,
    String? remarkCluster,
    String? houseName,
    String? commonName,
    String? sbkName,
    String? category,
    String? namaContractor,
    String? namaEmployee,
    String? jabatanEmployee,
    String? alamatEmployee,
    String? idQcForm,
    String? qcTransId,
    String? harga,
    String? wCreatedBy,
    String? wAprv1By,
    String? wAprv2By,
    String? wReject1By,
    String? wReject2By,
    String? remarkQc,
    String? remarks,
    String? dtAprv1,
    String? aprv1By,
    String? dtAprv2,
    String? aprv2By,
    List<ApprovalSpkArticle>? article,
  }) {
    return ApprovalSpk(
      idSpk: idSpk ?? this.idSpk,
      spkType: spkType ?? this.spkType,
      dtReject: dtReject ?? this.dtReject,
      rejectBy: rejectBy ?? this.rejectBy,
      dtReject2: dtReject2 ?? this.dtReject2,
      reject2By: reject2By ?? this.reject2By,
      siteName: siteName ?? this.siteName,
      remark: remark ?? this.remark,
      clusterName: clusterName ?? this.clusterName,
      remarkCluster: remarkCluster ?? this.remarkCluster,
      houseName: houseName ?? this.houseName,
      commonName: commonName ?? this.commonName,
      sbkName: sbkName ?? this.sbkName,
      category: category ?? this.category,
      namaContractor: namaContractor ?? this.namaContractor,
      namaEmployee: namaEmployee ?? this.namaEmployee,
      jabatanEmployee: jabatanEmployee ?? this.jabatanEmployee,
      alamatEmployee: alamatEmployee ?? this.alamatEmployee,
      idQcForm: idQcForm ?? this.idQcForm,
      qcTransId: qcTransId ?? this.qcTransId,
      harga: harga ?? this.harga,
      wCreatedBy: wCreatedBy ?? this.wCreatedBy,
      wAprv1By: wAprv1By ?? this.wAprv1By,
      wAprv2By: wAprv2By ?? this.wAprv2By,
      wReject1By: wReject1By ?? this.wReject1By,
      wReject2By: wReject2By ?? this.wReject2By,
      remarkQc: remarkQc ?? this.remarkQc,
      remarks: remarks ?? this.remarks,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      aprv1By: aprv1By ?? this.aprv1By,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      aprv2By: aprv2By ?? this.aprv2By,
      article: article ?? this.article,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_spk': idSpk,
      'spk_type': spkType,
      'dt_reject': dtReject,
      'reject_by': rejectBy,
      'dt_reject2': dtReject2,
      'reject2_by': reject2By,
      'site_name': siteName,
      'remark': remark,
      'cluster_name': clusterName,
      'remark_cluster': remarkCluster,
      'house_name': houseName,
      'common_name': commonName,
      'sbk_name': sbkName,
      'category': category,
      'nama_contractor': namaContractor,
      'nama_employee': namaEmployee,
      'jabatan_employee': jabatanEmployee,
      'alamat_employee': alamatEmployee,
      'id_qc_form': idQcForm,
      'qc_trans_id': qcTransId,
      'harga': harga,
      'w_created_by': wCreatedBy,
      'w_aprv1_by': wAprv1By,
      'w_aprv2_by': wAprv2By,
      'w_reject1_by': wReject1By,
      'w_reject2_by': wReject2By,
      'remark_qc': remarkQc,
      'remarks': remarks,
      'dt_aprv1': dtAprv1,
      'aprv1_by': aprv1By,
      'dt_aprv2': dtAprv2,
      'aprv2_by': aprv2By,
      'article': article.map((x) => x.toMap()).toList(),
    };
  }

  factory ApprovalSpk.fromMap(Map<String, dynamic> map) {
    return ApprovalSpk(
      idSpk: map['id_spk'] ?? '',
      spkType: map['spk_type'] ?? '',
      dtReject: map['dt_reject'] ?? '',
      rejectBy: map['reject_by'] ?? '',
      dtReject2: map['dt_reject2'] ?? '',
      reject2By: map['reject2_by'] ?? '',
      siteName: map['site_name'] ?? '',
      remark: map['remark'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      remarkCluster: map['remark_cluster'] ?? '',
      houseName: map['house_name'] ?? '',
      commonName: map['common_name'] ?? '',
      sbkName: map['sbk_name'] ?? '',
      category: map['category'] ?? '',
      namaContractor: map['nama_contractor'] ?? '',
      namaEmployee: map['nama_employee'] ?? '',
      jabatanEmployee: map['jabatan_employee'] ?? '',
      alamatEmployee: map['alamat_employee'] ?? '',
      idQcForm: map['id_qc_form'] ?? '',
      qcTransId: map['qc_trans_id'] ?? '',
      harga: map['harga'] ?? '',
      wCreatedBy: map['w_created_by'] ?? '',
      wAprv1By: map['w_aprv1_by'] ?? '',
      wAprv2By: map['w_aprv2_by'] ?? '',
      wReject1By: map['w_reject1_by'] ?? '',
      wReject2By: map['w_reject2_by'] ?? '',
      remarkQc: map['remark_qc'] ?? '',
      remarks: map['remarks'] ?? '',
      dtAprv1: map['dt_aprv1'] ?? '',
      aprv1By: map['aprv1_by'] ?? '',
      dtAprv2: map['dt_aprv2'] ?? '',
      aprv2By: map['aprv2_by'] ?? '',
      article: List<ApprovalSpkArticle>.from(
        map['article']?.map((x) => ApprovalSpkArticle.fromMap(x)) ?? [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalSpk.fromJson(String source) =>
      ApprovalSpk.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalSpk(idSpk: $idSpk, spkType: $spkType, dtReject: $dtReject, rejectBy: $rejectBy, dtReject2: $dtReject2, reject2By: $reject2By, siteName: $siteName, remark: $remark, clusterName: $clusterName, remarkCluster: $remarkCluster, houseName: $houseName, commonName: $commonName, sbkName: $sbkName, category: $category, namaContractor: $namaContractor, namaEmployee: $namaEmployee, jabatanEmployee: $jabatanEmployee, alamatEmployee: $alamatEmployee, idQcForm: $idQcForm, qcTransId: $qcTransId, harga: $harga, wCreatedBy: $wCreatedBy, wAprv1By: $wAprv1By, wAprv2By: $wAprv2By, wReject1By: $wReject1By, wReject2By: $wReject2By, remarkQc: $remarkQc, remarks: $remarks), dtAprv1: $dtAprv1, aprv1By: $aprv1By, dtAprv2: $dtAprv2, aprv2By: $aprv2By, article: $article)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalSpk &&
        other.idSpk == idSpk &&
        other.spkType == spkType &&
        other.dtReject == dtReject &&
        other.rejectBy == rejectBy &&
        other.dtReject2 == dtReject2 &&
        other.reject2By == reject2By &&
        other.siteName == siteName &&
        other.remark == remark &&
        other.clusterName == clusterName &&
        other.remarkCluster == remarkCluster &&
        other.houseName == houseName &&
        other.commonName == commonName &&
        other.sbkName == sbkName &&
        other.category == category &&
        other.namaContractor == namaContractor &&
        other.namaEmployee == namaEmployee &&
        other.jabatanEmployee == jabatanEmployee &&
        other.alamatEmployee == alamatEmployee &&
        other.idQcForm == idQcForm &&
        other.qcTransId == qcTransId &&
        other.harga == harga &&
        other.wCreatedBy == wCreatedBy &&
        other.wAprv1By == wAprv1By &&
        other.wAprv2By == wAprv2By &&
        other.wReject1By == wReject1By &&
        other.wReject2By == wReject2By &&
        other.remarkQc == remarkQc &&
        other.remarks == remarks &&
        other.dtAprv1 == dtAprv1 &&
        other.aprv1By == aprv1By &&
        other.dtAprv2 == dtAprv2 &&
        other.aprv2By == aprv2By &&
        other.article == article;
  }

  @override
  int get hashCode {
    return idSpk.hashCode ^
        spkType.hashCode ^
        dtReject.hashCode ^
        rejectBy.hashCode ^
        dtReject2.hashCode ^
        reject2By.hashCode ^
        siteName.hashCode ^
        remark.hashCode ^
        clusterName.hashCode ^
        remarkCluster.hashCode ^
        houseName.hashCode ^
        commonName.hashCode ^
        sbkName.hashCode ^
        category.hashCode ^
        namaContractor.hashCode ^
        namaEmployee.hashCode ^
        jabatanEmployee.hashCode ^
        alamatEmployee.hashCode ^
        idQcForm.hashCode ^
        qcTransId.hashCode ^
        harga.hashCode ^
        wCreatedBy.hashCode ^
        wAprv1By.hashCode ^
        wAprv2By.hashCode ^
        wReject1By.hashCode ^
        wReject2By.hashCode ^
        remarkQc.hashCode ^
        remarks.hashCode ^
        dtAprv1.hashCode ^
        aprv1By.hashCode ^
        dtAprv2.hashCode ^
        aprv2By.hashCode ^
        article.hashCode;
  }
}
