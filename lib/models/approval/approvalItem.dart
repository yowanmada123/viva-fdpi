import 'dart:convert';

import 'package:flutter/foundation.dart';

class ApprovalItem {
  final String idSpk;
  final String pihak1;
  final String pihak2;
  final String idSite;
  final String idCluster;
  final String idHouseUnit;
  final String activeFlag;
  final String status;
  final String dateStart;
  final String dateTarget;
  final String dateFinish;
  final String dtCreated;
  final String dtModified;
  final String createBy;
  final String modifiedBy;
  final String idUrut;
  final String idCetak;
  final String dtAprv1;
  final String aprv1By;
  final String dtAprv2;
  final String aprv2By;
  final String idSpb;
  final String amt;
  final String amtInclude;
  final String amtExclude;
  final String spkType;
  final String dtReject;
  final String rejectBy;
  final String dtReject2;
  final String reject2By;
  final String invId;
  final String siteName;
  final String remark;
  final String clusterName;
  final String remarkCluster;
  final String houseName;
  final String commonName;
  final String sbkName;
  final String category;
  final String namaContractor;
  final String contactName;
  final String alamatContractor;
  final String namaEmployee;
  final String jabatanEmployee;
  final String alamatEmployee;
  final String idQcForm;
  final String qcTransId;
  final String harga;
  final List<dynamic> article;
  final List<dynamic> articleIn;
  final String articleInDesc;
  final List<dynamic> articleEx;
  final String articleExDesc;
  final String remarkQc;
  final String remarks;

  ApprovalItem({
    required this.idSpk,
    required this.pihak1,
    required this.pihak2,
    required this.idSite,
    required this.idCluster,
    required this.idHouseUnit,
    required this.activeFlag,
    required this.status,
    required this.dateStart,
    required this.dateTarget,
    required this.dateFinish,
    required this.dtCreated,
    required this.dtModified,
    required this.createBy,
    required this.modifiedBy,
    required this.idUrut,
    required this.idCetak,
    required this.dtAprv1,
    required this.aprv1By,
    required this.dtAprv2,
    required this.aprv2By,
    required this.idSpb,
    required this.amt,
    required this.amtInclude,
    required this.amtExclude,
    required this.spkType,
    required this.dtReject,
    required this.rejectBy,
    required this.dtReject2,
    required this.reject2By,
    required this.invId,
    required this.siteName,
    required this.remark,
    required this.clusterName,
    required this.remarkCluster,
    required this.houseName,
    required this.commonName,
    required this.sbkName,
    required this.category,
    required this.namaContractor,
    required this.contactName,
    required this.alamatContractor,
    required this.namaEmployee,
    required this.jabatanEmployee,
    required this.alamatEmployee,
    required this.idQcForm,
    required this.qcTransId,
    required this.harga,
    required this.article,
    required this.articleIn,
    required this.articleInDesc,
    required this.articleEx,
    required this.articleExDesc,
    required this.remarkQc,
    required this.remarks,
  });

  ApprovalItem copyWith({
    String? idSpk,
    String? pihak1,
    String? pihak2,
    String? idSite,
    String? idCluster,
    String? idHouseUnit,
    String? activeFlag,
    String? status,
    String? dateStart,
    String? dateTarget,
    String? dateFinish,
    String? dtCreated,
    String? dtModified,
    String? createBy,
    String? modifiedBy,
    String? idUrut,
    String? idCetak,
    String? dtAprv1,
    String? aprv1By,
    String? dtAprv2,
    String? aprv2By,
    String? idSpb,
    String? amt,
    String? amtInclude,
    String? amtExclude,
    String? spkType,
    String? dtReject,
    String? rejectBy,
    String? dtReject2,
    String? reject2By,
    String? invId,
    String? siteName,
    String? remark,
    String? clusterName,
    String? remarkCluster,
    String? houseName,
    String? commonName,
    String? sbkName,
    String? category,
    String? namaContractor,
    String? contactName,
    String? alamatContractor,
    String? namaEmployee,
    String? jabatanEmployee,
    String? alamatEmployee,
    String? idQcForm,
    String? qcTransId,
    String? harga,
    List<dynamic>? article,
    List<dynamic>? articleIn,
    String? articleInDesc,
    List<dynamic>? articleEx,
    String? articleExDesc,
    String? remarkQc,
    String? remarks,
  }) {
    return ApprovalItem(
      idSpk: idSpk ?? this.idSpk,
      pihak1: pihak1 ?? this.pihak1,
      pihak2: pihak2 ?? this.pihak2,
      idSite: idSite ?? this.idSite,
      idCluster: idCluster ?? this.idCluster,
      idHouseUnit: idHouseUnit ?? this.idHouseUnit,
      activeFlag: activeFlag ?? this.activeFlag,
      status: status ?? this.status,
      dateStart: dateStart ?? this.dateStart,
      dateTarget: dateTarget ?? this.dateTarget,
      dateFinish: dateFinish ?? this.dateFinish,
      dtCreated: dtCreated ?? this.dtCreated,
      dtModified: dtModified ?? this.dtModified,
      createBy: createBy ?? this.createBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      idUrut: idUrut ?? this.idUrut,
      idCetak: idCetak ?? this.idCetak,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      aprv1By: aprv1By ?? this.aprv1By,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      aprv2By: aprv2By ?? this.aprv2By,
      idSpb: idSpb ?? this.idSpb,
      amt: amt ?? this.amt,
      amtInclude: amtInclude ?? this.amtInclude,
      amtExclude: amtExclude ?? this.amtExclude,
      spkType: spkType ?? this.spkType,
      dtReject: dtReject ?? this.dtReject,
      rejectBy: rejectBy ?? this.rejectBy,
      dtReject2: dtReject2 ?? this.dtReject2,
      reject2By: reject2By ?? this.reject2By,
      invId: invId ?? this.invId,
      siteName: siteName ?? this.siteName,
      remark: remark ?? this.remark,
      clusterName: clusterName ?? this.clusterName,
      remarkCluster: remarkCluster ?? this.remarkCluster,
      houseName: houseName ?? this.houseName,
      commonName: commonName ?? this.commonName,
      sbkName: sbkName ?? this.sbkName,
      category: category ?? this.category,
      namaContractor: namaContractor ?? this.namaContractor,
      contactName: contactName ?? this.contactName,
      alamatContractor: alamatContractor ?? this.alamatContractor,
      namaEmployee: namaEmployee ?? this.namaEmployee,
      jabatanEmployee: jabatanEmployee ?? this.jabatanEmployee,
      alamatEmployee: alamatEmployee ?? this.alamatEmployee,
      idQcForm: idQcForm ?? this.idQcForm,
      qcTransId: qcTransId ?? this.qcTransId,
      harga: harga ?? this.harga,
      article: article ?? this.article,
      articleIn: articleIn ?? this.articleIn,
      articleInDesc: articleInDesc ?? this.articleInDesc,
      articleEx: articleEx ?? this.articleEx,
      articleExDesc: articleExDesc ?? this.articleExDesc,
      remarkQc: remarkQc ?? this.remarkQc,
      remarks: remarks ?? this.remarks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_spk': idSpk,
      'pihak_1': pihak1,
      'pihak_2': pihak2,
      'id_site': idSite,
      'id_cluster': idCluster,
      'id_house_unit': idHouseUnit,
      'active_flag': activeFlag,
      'status': status,
      'date_start': dateStart,
      'date_target': dateTarget,
      'date_finish': dateFinish,
      'dt_created': dtCreated,
      'dt_modified': dtModified,
      'create_by': createBy,
      'modified_by': modifiedBy,
      'id_urut': idUrut,
      'id_cetak': idCetak,
      'dt_aprv1': dtAprv1,
      'aprv1_by': aprv1By,
      'dt_aprv2': dtAprv2,
      'aprv2_by': aprv2By,
      'id_spb': idSpb,
      'amt': amt,
      'amt_include': amtInclude,
      'amt_exclude': amtExclude,
      'spk_type': spkType,
      'dt_reject': dtReject,
      'reject_by': rejectBy,
      'dt_reject2': dtReject2,
      'reject2_by': reject2By,
      'inv_id': invId,
      'site_name': siteName,
      'remark': remark,
      'cluster_name': clusterName,
      'remark_cluster': remarkCluster,
      'house_name': houseName,
      'common_name': commonName,
      'sbk_name': sbkName,
      'category': category,
      'nama_contractor': namaContractor,
      'contact_name': contactName,
      'alamat_contractor': alamatContractor,
      'nama_employee': namaEmployee,
      'jabatan_employee': jabatanEmployee,
      'alamat_employee': alamatEmployee,
      'id_qc_form': idQcForm,
      'qc_trans_id': qcTransId,
      'harga': harga,
      'article': article.map((x) => x.toMap()).toList(),
      'article_in': articleIn,
      'article_in_desc': articleInDesc,
      'article_ex': articleEx,
      'article_ex_desc': articleExDesc,
      'remark_qc': remarkQc,
      'remarks': remarks,
    };
  }

  factory ApprovalItem.fromMap(Map<String, dynamic> map) {
    return ApprovalItem(
      idSpk: map['id_spk'] ?? '',
      pihak1: map['pihak_1'] ?? '',
      pihak2: map['pihak_2'] ?? '',
      idSite: map['id_site'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      idHouseUnit: map['id_house_unit'] ?? '',
      activeFlag: map['active_flag'] ?? '',
      status: map['status'] ?? '',
      dateStart: map['date_start'] ?? '',
      dateTarget: map['date_target'] ?? '',
      dateFinish: map['date_finish'] ?? '',
      dtCreated: map['dt_created'] ?? '',
      dtModified: map['dt_modified'] ?? '',
      createBy: map['create_by'] ?? '',
      modifiedBy: map['modified_by'] ?? '',
      idUrut: map['id_urut'] ?? '',
      idCetak: map['id_cetak'] ?? '',
      dtAprv1: map['dt_aprv1'] ?? '',
      aprv1By: map['aprv1_by'] ?? '',
      dtAprv2: map['dt_aprv2'] ?? '',
      aprv2By: map['aprv2_by'] ?? '',
      idSpb: map['id_spb'] ?? '',
      amt: map['amt'] ?? '',
      amtInclude: map['amt_include'] ?? '',
      amtExclude: map['amt_exclude'] ?? '',
      spkType: map['spk_type'] ?? '',
      dtReject: map['dt_reject'] ?? '',
      rejectBy: map['reject_by'] ?? '',
      dtReject2: map['dt_reject2'] ?? '',
      reject2By: map['reject2_by'] ?? '',
      invId: map['inv_id'] ?? '',
      siteName: map['site_name'] ?? '',
      remark: map['remark'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      remarkCluster: map['remark_cluster'] ?? '',
      houseName: map['house_name'] ?? '',
      commonName: map['common_name'] ?? '',
      sbkName: map['sbk_name'] ?? '',
      category: map['category'] ?? '',
      namaContractor: map['nama_contractor'] ?? '',
      contactName: map['contact_name'] ?? '',
      alamatContractor: map['alamat_contractor'] ?? '',
      namaEmployee: map['nama_employee'] ?? '',
      jabatanEmployee: map['jabatan_employee'] ?? '',
      alamatEmployee: map['alamat_employee'] ?? '',
      idQcForm: map['id_qc_form'] ?? '',
      qcTransId: map['qc_trans_id'] ?? '',
      harga: map['harga'] ?? '',
      article: List<dynamic>.from(map['article']),
      articleIn: List<dynamic>.from(map['article_in']),
      articleInDesc: map['article_in_desc'] ?? '',
      articleEx: List<dynamic>.from(map['article_ex']),
      articleExDesc: map['article_ex_desc'] ?? '',
      remarkQc: map['remark_qc'] ?? '',
      remarks: map['remarks'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalItem.fromJson(String source) =>
      ApprovalItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalItem(idSpk: $idSpk, pihak1: $pihak1, pihak2: $pihak2, idSite: $idSite, idCluster: $idCluster, idHouseUnit: $idHouseUnit, activeFlag: $activeFlag, status: $status, dateStart: $dateStart, dateTarget: $dateTarget, dateFinish: $dateFinish, dtCreated: $dtCreated, dtModified: $dtModified, createBy: $createBy, modifiedBy: $modifiedBy, idUrut: $idUrut, idCetak: $idCetak, dtAprv1: $dtAprv1, aprv1By: $aprv1By, dtAprv2: $dtAprv2, aprv2By: $aprv2By, idSpb: $idSpb, amt: $amt, amtInclude: $amtInclude, amtExclude: $amtExclude, spkType: $spkType, dtReject: $dtReject, rejectBy: $rejectBy, dtReject2: $dtReject2, reject2By: $reject2By, invId: $invId, siteName: $siteName, remark: $remark, clusterName: $clusterName, remarkCluster: $remarkCluster, houseName: $houseName, commonName: $commonName, sbkName: $sbkName, category: $category, namaContractor: $namaContractor, contactName: $contactName, alamatContractor: $alamatContractor, namaEmployee: $namaEmployee, jabatanEmployee: $jabatanEmployee, alamatEmployee: $alamatEmployee, idQcForm: $idQcForm, qcTransId: $qcTransId, harga: $harga, article: $article, articleIn: $articleIn, articleInDesc: $articleInDesc, articleEx: $articleEx, articleExDesc: $articleExDesc, remarkQc: $remarkQc, remarks: $remarks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalItem &&
        other.idSpk == idSpk &&
        other.pihak1 == pihak1 &&
        other.pihak2 == pihak2 &&
        other.idSite == idSite &&
        other.idCluster == idCluster &&
        other.idHouseUnit == idHouseUnit &&
        other.activeFlag == activeFlag &&
        other.status == status &&
        other.dateStart == dateStart &&
        other.dateTarget == dateTarget &&
        other.dateFinish == dateFinish &&
        other.dtCreated == dtCreated &&
        other.dtModified == dtModified &&
        other.createBy == createBy &&
        other.modifiedBy == modifiedBy &&
        other.idUrut == idUrut &&
        other.idCetak == idCetak &&
        other.dtAprv1 == dtAprv1 &&
        other.aprv1By == aprv1By &&
        other.dtAprv2 == dtAprv2 &&
        other.aprv2By == aprv2By &&
        other.idSpb == idSpb &&
        other.amt == amt &&
        other.amtInclude == amtInclude &&
        other.amtExclude == amtExclude &&
        other.spkType == spkType &&
        other.dtReject == dtReject &&
        other.rejectBy == rejectBy &&
        other.dtReject2 == dtReject2 &&
        other.reject2By == reject2By &&
        other.invId == invId &&
        other.siteName == siteName &&
        other.remark == remark &&
        other.clusterName == clusterName &&
        other.remarkCluster == remarkCluster &&
        other.houseName == houseName &&
        other.commonName == commonName &&
        other.sbkName == sbkName &&
        other.category == category &&
        other.namaContractor == namaContractor &&
        other.contactName == contactName &&
        other.alamatContractor == alamatContractor &&
        other.namaEmployee == namaEmployee &&
        other.jabatanEmployee == jabatanEmployee &&
        other.alamatEmployee == alamatEmployee &&
        other.idQcForm == idQcForm &&
        other.qcTransId == qcTransId &&
        other.harga == harga &&
        listEquals(other.article, article) &&
        listEquals(other.articleIn, articleIn) &&
        other.articleInDesc == articleInDesc &&
        listEquals(other.articleEx, articleEx) &&
        other.articleExDesc == articleExDesc &&
        other.remarkQc == remarkQc &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return idSpk.hashCode ^
        pihak1.hashCode ^
        pihak2.hashCode ^
        idSite.hashCode ^
        idCluster.hashCode ^
        idHouseUnit.hashCode ^
        activeFlag.hashCode ^
        status.hashCode ^
        dateStart.hashCode ^
        dateTarget.hashCode ^
        dateFinish.hashCode ^
        dtCreated.hashCode ^
        dtModified.hashCode ^
        createBy.hashCode ^
        modifiedBy.hashCode ^
        idUrut.hashCode ^
        idCetak.hashCode ^
        dtAprv1.hashCode ^
        aprv1By.hashCode ^
        dtAprv2.hashCode ^
        aprv2By.hashCode ^
        idSpb.hashCode ^
        amt.hashCode ^
        amtInclude.hashCode ^
        amtExclude.hashCode ^
        spkType.hashCode ^
        dtReject.hashCode ^
        rejectBy.hashCode ^
        dtReject2.hashCode ^
        reject2By.hashCode ^
        invId.hashCode ^
        siteName.hashCode ^
        remark.hashCode ^
        clusterName.hashCode ^
        remarkCluster.hashCode ^
        houseName.hashCode ^
        commonName.hashCode ^
        sbkName.hashCode ^
        category.hashCode ^
        namaContractor.hashCode ^
        contactName.hashCode ^
        alamatContractor.hashCode ^
        namaEmployee.hashCode ^
        jabatanEmployee.hashCode ^
        alamatEmployee.hashCode ^
        idQcForm.hashCode ^
        qcTransId.hashCode ^
        harga.hashCode ^
        article.hashCode ^
        articleIn.hashCode ^
        articleInDesc.hashCode ^
        articleEx.hashCode ^
        articleExDesc.hashCode ^
        remarkQc.hashCode ^
        remarks.hashCode;
  }
}
