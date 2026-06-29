import 'dart:convert';

import 'package:fdpi_app/models/fdpi/spk_review/spk_article.dart';

class Spk {
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
  final String dtCompleted;

  final String luasBangunan;

  final String remark;
  final String remarkSpk;

  final String customLb;

  final String siteName;
  final String clusterName;
  final String remarkCluster;
  final String houseName;
  final String buildingArea;
  final String commonName;
  final String sbkName;
  final String category;

  final String namaContractor;
  final String contactName;
  final String alamatContractor;
  final String phone;
  final String nik;
  final String businessName;

  final String namaEmployee;
  final String jabatanEmployee;
  final String alamatEmployee;

  final String idQcForm;
  final String qcTransId;

  final String harga;

  final String remarkArticle;
  final String remarkQc;
  final String remarks;

  final List<SpkArticle> article;

  Spk({
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
    required this.dtCompleted,
    required this.luasBangunan,
    required this.remark,
    required this.remarkSpk,
    required this.customLb,
    required this.siteName,
    required this.clusterName,
    required this.remarkCluster,
    required this.houseName,
    required this.buildingArea,
    required this.commonName,
    required this.sbkName,
    required this.category,
    required this.namaContractor,
    required this.contactName,
    required this.alamatContractor,
    required this.phone,
    required this.nik,
    required this.businessName,
    required this.namaEmployee,
    required this.jabatanEmployee,
    required this.alamatEmployee,
    required this.idQcForm,
    required this.qcTransId,
    required this.harga,
    required this.remarkArticle,
    required this.remarkQc,
    required this.remarks,
    required this.article,
  });

  factory Spk.fromMap(Map<String, dynamic> map) {
    return Spk(
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
      dtCompleted: map['dt_completed'] ?? '',
      luasBangunan: map['luas_bangunan'] ?? '',
      remark: map['remark'] ?? '',
      remarkSpk: map['remark_spk'] ?? '',
      customLb: map['custom_lb'] ?? '',
      siteName: map['site_name'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      remarkCluster: map['remark_cluster'] ?? '',
      houseName: map['house_name'] ?? '',
      buildingArea: map['building_area'] ?? '',
      commonName: map['common_name'] ?? '',
      sbkName: map['sbk_name'] ?? '',
      category: map['category'] ?? '',
      namaContractor: map['nama_contractor'] ?? '',
      contactName: map['contact_name'] ?? '',
      alamatContractor: map['alamat_contractor'] ?? '',
      phone: map['phone'] ?? '',
      nik: map['nik'] ?? '',
      businessName: map['business_name'] ?? '',
      namaEmployee: map['nama_employee'] ?? '',
      jabatanEmployee: map['jabatan_employee'] ?? '',
      alamatEmployee: map['alamat_employee'] ?? '',
      idQcForm: map['id_qc_form'] ?? '',
      qcTransId: map['qc_trans_id'] ?? '',
      harga: map['harga'] ?? '',
      remarkArticle: map['remark_article'] ?? '',
      remarkQc: map['remark_qc'] ?? '',
      remarks: map['remarks'] ?? '',
      article:
          (map['article'] as List<dynamic>? ?? [])
              .map((e) => SpkArticle.fromMap(e))
              .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    // isi seluruh field yang sama seperti fromMap
  };

  String toJson() => json.encode(toMap());

  factory Spk.fromJson(String source) => Spk.fromMap(json.decode(source));
}
