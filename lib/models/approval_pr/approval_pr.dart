import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../utils/datetime_convertion.dart';

class ApprovalPR {
  final String prId;
  final DateTime? dtPr;
  final String deptId;
  final String address;
  final String city;
  final String deptName;
  final String qty;
  final String picId;
  final String vendorId;
  final String vendorName;
  final String wgt;
  final String prNum;
  final String stat;
  final String memoTxt;
  final String trType;
  final DateTime? dtAprv;
  final DateTime? dtAprv2;
  final DateTime? dtRjc;
  final DateTime? dtRjc2;
  final String aprvBy;
  final String aprv2By;
  final String rjcBy;
  final String rjc2By;
  final String siteName;
  final String clusterName;
  final String houseName;
  final String officeId;
  final String office;
  final String wCreatedBy;
  final String wAprv1By;
  final String wAprv2By;
  final String typePr;
  final List<ApprovalArticlePR> article;
  ApprovalPR({
    required this.prId,
    required this.dtPr,
    required this.deptId,
    required this.address,
    required this.city,
    required this.deptName,
    required this.qty,
    required this.picId,
    required this.vendorId,
    required this.vendorName,
    required this.wgt,
    required this.prNum,
    required this.stat,
    required this.memoTxt,
    required this.trType,
    required this.dtAprv,
    required this.dtAprv2,
    required this.dtRjc,
    required this.dtRjc2,
    required this.aprvBy,
    required this.aprv2By,
    required this.rjcBy,
    required this.rjc2By,
    required this.siteName,
    required this.clusterName,
    required this.houseName,
    required this.officeId,
    required this.office,
    required this.wCreatedBy,
    required this.wAprv1By,
    required this.wAprv2By,
    required this.typePr,
    required this.article,
  });

  ApprovalPR copyWith({
    String? prId,
    DateTime? dtPr,
    String? deptId,
    String? address,
    String? city,
    String? deptName,
    String? qty,
    String? picId,
    String? vendorId,
    String? vendorName,
    String? wgt,
    String? prNum,
    String? stat,
    String? memoTxt,
    String? trType,
    DateTime? dtAprv,
    DateTime? dtAprv2,
    DateTime? dtRjc,
    DateTime? dtRjc2,
    String? aprvBy,
    String? aprv2By,
    String? rjcBy,
    String? rjc2By,
    String? siteName,
    String? clusterName,
    String? houseName,
    String? officeId,
    String? office,
    String? wCreatedBy,
    String? wAprv1By,
    String? wAprv2By,
    String? typePr,
    List<ApprovalArticlePR>? article,
  }) {
    return ApprovalPR(
      prId: prId ?? this.prId,
      dtPr: dtPr ?? this.dtPr,
      deptId: deptId ?? this.deptId,
      address: address ?? this.address,
      city: city ?? this.city,
      deptName: deptName ?? this.deptName,
      qty: qty ?? this.qty,
      picId: picId ?? this.picId,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      wgt: wgt ?? this.wgt,
      prNum: prNum ?? this.prNum,
      stat: stat ?? this.stat,
      memoTxt: memoTxt ?? this.memoTxt,
      trType: trType ?? this.trType,
      dtAprv: dtAprv ?? this.dtAprv,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      dtRjc: dtRjc ?? this.dtRjc,
      dtRjc2: dtRjc2 ?? this.dtRjc2,
      aprvBy: aprvBy ?? this.aprvBy,
      aprv2By: aprv2By ?? this.aprv2By,
      rjcBy: rjcBy ?? this.rjcBy,
      rjc2By: rjc2By ?? this.rjc2By,
      siteName: siteName ?? this.siteName,
      clusterName: clusterName ?? this.clusterName,
      houseName: houseName ?? this.houseName,
      officeId: officeId ?? this.officeId,
      office: office ?? this.office,
      wCreatedBy: wCreatedBy ?? this.wCreatedBy,
      wAprv1By: wAprv1By ?? this.wAprv1By,
      wAprv2By: wAprv2By ?? this.wAprv2By,
      typePr: typePr ?? this.typePr,
      article: article ?? this.article,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pr_id': prId,
      'dt_pr': dtPr,
      'dept_id': deptId,
      'address': address,
      'city': city,
      'dept_name': deptName,
      'qty': qty,
      'pic_id': picId,
      'vendor_id': vendorId,
      'vendor_name': vendorName,
      'wgt': wgt,
      'pr_num': prNum,
      'stat': stat,
      'memo_txt': memoTxt,
      'tr_type': trType,
      'dt_aprv': dtAprv,
      'dt_aprv2': dtAprv2,
      'dt_rjc': dtRjc,
      'dt_rjc2': dtRjc2,
      'aprv_by': aprvBy,
      'aprv2_by': aprv2By,
      'rjc_by': rjcBy,
      'rjc2_by': rjc2By,
      'site_name': siteName,
      'cluster_name': clusterName,
      'house_name': houseName,
      'office_id': officeId,
      'office': office,
      'w_created_by': wCreatedBy,
      'w_aprv1_by': wAprv1By,
      'w_aprv2_by': wAprv2By,
      'type_pr': typePr,
      'article': article,
    };
  }

  factory ApprovalPR.fromMap(Map<String, dynamic> map) {
    return ApprovalPR(
      prId: map['pr_id'] ?? '',
      dtPr: parseDateTime(map['dt_pr'] ?? ''),
      deptId: map['dept_id'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      deptName: map['dept_name'] ?? '',
      qty: map['qty'] ?? '',
      picId: map['pic_id'] ?? '',
      vendorId: map['vendor_id'] ?? '',
      vendorName: map['vendor_name'] ?? '',
      wgt: map['wgt'] ?? '',
      prNum: map['pr_num'] ?? '',
      stat: map['stat'] ?? '',
      memoTxt: map['memo_txt'] ?? '',
      trType: map['tr_type'] ?? '',
      dtAprv: parseDateTime(map['dt_aprv'] ?? ''),
      dtAprv2: parseDateTime(map['dt_aprv2'] ?? ''),
      dtRjc: parseDateTime(map['dt_rjc'] ?? ''),
      dtRjc2: parseDateTime(map['dt_rjc2'] ?? ''),
      aprvBy: map['aprv_by'] ?? '',
      aprv2By: map['aprv2_by'] ?? '',
      rjcBy: map['rjc_by'] ?? '',
      rjc2By: map['rjc2_by'] ?? '',
      siteName: map['site_name'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      houseName: map['house_name'] ?? '',
      officeId: map['office_id'] ?? '',
      office: map['office'] ?? '',
      wCreatedBy: map['w_created_by'] ?? '',
      wAprv1By: map['w_aprv1_by'] ?? '',
      wAprv2By: map['w_aprv2_by'] ?? '',
      typePr: map['type_pr'] ?? '',
      article: List<ApprovalArticlePR>.from(
        map['article']?.map((x) => ApprovalArticlePR.fromMap(x)) ?? [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalPR.fromJson(String source) =>
      ApprovalPR.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalPR(prId: $prId, dtPr: $dtPr, deptId: $deptId, address: $address, city: $city, deptName: $deptName, qty: $qty, picId: $picId, vendorId: $vendorId, vendorName: $vendorName, wgt: $wgt, prNum: $prNum, stat: $stat, memoTxt: $memoTxt, trType: $trType, dtAprv: $dtAprv, dtAprv2: $dtAprv2, dtRjc: $dtRjc, dtRjc2: $dtRjc2, aprvBy: $aprvBy, aprv2By: $aprv2By, rjcBy: $rjcBy, rjc2By: $rjc2By, siteName: $siteName, clusterName: $clusterName, houseName: $houseName, officeId: $officeId, office: $office, wCreatedBy: $wCreatedBy, wAprv1By: $wAprv1By, wAprv2By: $wAprv2By, article: $article, typePr: $typePr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalPR &&
        other.prId == prId &&
        other.dtPr == dtPr &&
        other.deptId == deptId &&
        other.address == address &&
        other.city == city &&
        other.deptName == deptName &&
        other.qty == qty &&
        other.picId == picId &&
        other.vendorId == vendorId &&
        other.vendorName == vendorName &&
        other.wgt == wgt &&
        other.prNum == prNum &&
        other.stat == stat &&
        other.memoTxt == memoTxt &&
        other.trType == trType &&
        other.dtAprv == dtAprv &&
        other.dtAprv2 == dtAprv2 &&
        other.dtRjc == dtRjc &&
        other.dtRjc2 == dtRjc2 &&
        other.aprvBy == aprvBy &&
        other.aprv2By == aprv2By &&
        other.rjcBy == rjcBy &&
        other.rjc2By == rjc2By &&
        other.siteName == siteName &&
        other.clusterName == clusterName &&
        other.houseName == houseName &&
        other.officeId == officeId &&
        other.office == office &&
        other.wCreatedBy == wCreatedBy &&
        other.wAprv1By == wAprv1By &&
        other.wAprv2By == wAprv2By &&
        other.typePr == typePr &&
        listEquals(other.article, article);
  }

  @override
  int get hashCode {
    return prId.hashCode ^
        dtPr.hashCode ^
        deptId.hashCode ^
        address.hashCode ^
        city.hashCode ^
        deptName.hashCode ^
        qty.hashCode ^
        picId.hashCode ^
        vendorId.hashCode ^
        vendorName.hashCode ^
        wgt.hashCode ^
        prNum.hashCode ^
        stat.hashCode ^
        memoTxt.hashCode ^
        trType.hashCode ^
        dtAprv.hashCode ^
        dtAprv2.hashCode ^
        dtRjc.hashCode ^
        dtRjc2.hashCode ^
        aprvBy.hashCode ^
        aprv2By.hashCode ^
        rjcBy.hashCode ^
        rjc2By.hashCode ^
        siteName.hashCode ^
        clusterName.hashCode ^
        houseName.hashCode ^
        officeId.hashCode ^
        office.hashCode ^
        wCreatedBy.hashCode ^
        wAprv1By.hashCode ^
        wAprv2By.hashCode ^
        typePr.hashCode ^
        article.hashCode;
  }
}

class ApprovalArticlePR {
  final String no;
  final String prItem;
  final String prId;
  final String articleId;
  final String description;
  final String qty;
  final String unitMeas;
  final String remark;
  final String stat;
  final String officeId;
  final String wgt;
  final String dtCreated;
  final String dtModified;
  final String amount;
  final String unitPrice;
  final String clusterName;
  final String houseName;
  final String siteName;
  ApprovalArticlePR({
    required this.no,
    required this.prItem,
    required this.prId,
    required this.articleId,
    required this.description,
    required this.qty,
    required this.unitMeas,
    required this.remark,
    required this.stat,
    required this.officeId,
    required this.wgt,
    required this.dtCreated,
    required this.dtModified,
    required this.amount,
    required this.unitPrice,
    required this.clusterName,
    required this.houseName,
    required this.siteName,
  });

  ApprovalArticlePR copyWith({
    String? no,
    String? prItem,
    String? prId,
    String? articleId,
    String? description,
    String? qty,
    String? unitMeas,
    String? remark,
    String? stat,
    String? officeId,
    String? wgt,
    String? dtCreated,
    String? dtModified,
    String? amount,
    String? unitPrice,
    String? clusterName,
    String? houseName,
    String? siteName,
  }) {
    return ApprovalArticlePR(
      no: no ?? this.no,
      prItem: prItem ?? this.prItem,
      prId: prId ?? this.prId,
      articleId: articleId ?? this.articleId,
      description: description ?? this.description,
      qty: qty ?? this.qty,
      unitMeas: unitMeas ?? this.unitMeas,
      remark: remark ?? this.remark,
      stat: stat ?? this.stat,
      officeId: officeId ?? this.officeId,
      wgt: wgt ?? this.wgt,
      dtCreated: dtCreated ?? this.dtCreated,
      dtModified: dtModified ?? this.dtModified,
      amount: amount ?? this.amount,
      unitPrice: unitPrice ?? this.unitPrice,
      clusterName: clusterName ?? this.clusterName,
      houseName: houseName ?? this.houseName,
      siteName: siteName ?? this.siteName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'pr_item': prItem,
      'pr_id': prId,
      'article_id': articleId,
      'description': description,
      'qty': qty,
      'unit_meas': unitMeas,
      'remark': remark,
      'stat': stat,
      'office_id': officeId,
      'wgt': wgt,
      'dt_created': dtCreated,
      'dt_modified': dtModified,
      'amount': amount,
      'unit_price': unitPrice,
      'cluster_name': clusterName,
      'house_name': houseName,
      'site_name': siteName,
    };
  }

  factory ApprovalArticlePR.fromMap(Map<String, dynamic> map) {
    return ApprovalArticlePR(
      no: map['no'] ?? '',
      prItem: map['pr_item'] ?? '',
      prId: map['pr_id'] ?? '',
      articleId: map['article_id'] ?? '',
      description: map['description'] ?? '',
      qty: map['qty'] ?? '',
      unitMeas: map['unit_meas'] ?? '',
      remark: map['remark'] ?? '',
      stat: map['stat'] ?? '',
      officeId: map['office_id'] ?? '',
      wgt: map['wgt'] ?? '',
      dtCreated: map['dt_created'] ?? '',
      dtModified: map['dt_modified'] ?? '',
      amount: map['amount'] ?? '',
      unitPrice: map['unit_price'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      houseName: map['house_name'] ?? '',
      siteName: map['site_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalArticlePR.fromJson(String source) =>
      ApprovalArticlePR.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalArticlePR(no: $no, prItem: $prItem, prId: $prId, articleId: $articleId, description: $description, qty: $qty, unitMeas: $unitMeas, remark: $remark, stat: $stat, officeId: $officeId, wgt: $wgt, dtCreated: $dtCreated, dtModified: $dtModified, amount: $amount, unitPrice: $unitPrice, clusterName: $clusterName, houseName: $houseName, siteName: $siteName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalArticlePR &&
        other.no == no &&
        other.prItem == prItem &&
        other.prId == prId &&
        other.articleId == articleId &&
        other.description == description &&
        other.qty == qty &&
        other.unitMeas == unitMeas &&
        other.remark == remark &&
        other.stat == stat &&
        other.officeId == officeId &&
        other.wgt == wgt &&
        other.dtCreated == dtCreated &&
        other.dtModified == dtModified &&
        other.amount == amount &&
        other.unitPrice == unitPrice &&
        other.clusterName == clusterName &&
        other.houseName == houseName &&
        other.siteName == siteName;
  }

  @override
  int get hashCode {
    return no.hashCode ^
        prItem.hashCode ^
        prId.hashCode ^
        articleId.hashCode ^
        description.hashCode ^
        qty.hashCode ^
        unitMeas.hashCode ^
        remark.hashCode ^
        stat.hashCode ^
        officeId.hashCode ^
        wgt.hashCode ^
        dtCreated.hashCode ^
        dtModified.hashCode ^
        amount.hashCode ^
        unitPrice.hashCode ^
        clusterName.hashCode ^
        houseName.hashCode ^
        siteName.hashCode;
  }
}
