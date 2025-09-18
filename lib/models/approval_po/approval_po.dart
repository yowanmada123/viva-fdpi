import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../utils/datetime_convertion.dart';

class ApprovalPo {
  final String poId;
  final DateTime? dtPo;
  final String stat;
  final String picId;
  final String vendorId;
  final String vendorName;
  final String memoTxt;
  final String qty;
  final String amtSubtotal;
  final String amtDisc;
  final String amtNet;
  final String amtPpn;
  final String ppnPersen;
  final String ppn;
  final DateTime? dtAprv;
  final DateTime? dtAprv2;
  final DateTime? dtRjc;
  final DateTime? dtRjc2;
  final String aprvBy;
  final String aprv2By;
  final String rjcBy;
  final String rjc2By;
  final String payTermId;
  final String prId;
  final String deptName;
  final String officeId;
  final String office;
  final List<ApprovalArticlePO> article;
  ApprovalPo({
    required this.poId,
    required this.dtPo,
    required this.stat,
    required this.picId,
    required this.vendorId,
    required this.vendorName,
    required this.memoTxt,
    required this.qty,
    required this.amtSubtotal,
    required this.amtDisc,
    required this.amtNet,
    required this.amtPpn,
    required this.ppnPersen,
    required this.ppn,
    required this.dtAprv,
    required this.dtAprv2,
    required this.dtRjc,
    required this.dtRjc2,
    required this.aprvBy,
    required this.aprv2By,
    required this.rjcBy,
    required this.rjc2By,
    required this.payTermId,
    required this.prId,
    required this.deptName,
    required this.officeId,
    required this.office,
    required this.article,
  });

  ApprovalPo copyWith({
    String? poId,
    DateTime? dtPo,
    String? stat,
    String? picId,
    String? vendorId,
    String? vendorName,
    String? memoTxt,
    String? qty,
    String? amtSubtotal,
    String? amtDisc,
    String? amtNet,
    String? amtPpn,
    String? ppnPersen,
    String? ppn,
    DateTime? dtAprv,
    DateTime? dtAprv2,
    DateTime? dtRjc,
    DateTime? dtRjc2,
    String? aprvBy,
    String? aprv2By,
    String? rjcBy,
    String? rjc2By,
    String? payTermId,
    String? prId,
    String? deptName,
    String? officeId,
    String? office,
    List<ApprovalArticlePO>? article,
  }) {
    return ApprovalPo(
      poId: poId ?? this.poId,
      dtPo: dtPo ?? this.dtPo,
      stat: stat ?? this.stat,
      picId: picId ?? this.picId,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      memoTxt: memoTxt ?? this.memoTxt,
      qty: qty ?? this.qty,
      amtSubtotal: amtSubtotal ?? this.amtSubtotal,
      amtDisc: amtDisc ?? this.amtDisc,
      amtNet: amtNet ?? this.amtNet,
      amtPpn: amtPpn ?? this.amtPpn,
      ppnPersen: ppnPersen ?? this.ppnPersen,
      ppn: ppn ?? this.ppn,
      dtAprv: dtAprv ?? this.dtAprv,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      dtRjc: dtRjc ?? this.dtRjc,
      dtRjc2: dtRjc2 ?? this.dtRjc2,
      aprvBy: aprvBy ?? this.aprvBy,
      aprv2By: aprv2By ?? this.aprv2By,
      rjcBy: rjcBy ?? this.rjcBy,
      rjc2By: rjc2By ?? this.rjc2By,
      payTermId: payTermId ?? this.payTermId,
      prId: prId ?? this.prId,
      deptName: deptName ?? this.deptName,
      officeId: officeId ?? this.officeId,
      office: office ?? this.office,
      article: article ?? this.article,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'po_id': poId,
      'dt_po': dtPo,
      'stat': stat,
      'pic_id': picId,
      'vendor_id': vendorId,
      'vendor_name': vendorName,
      'memo_txt': memoTxt,
      'qty': qty,
      'amt_subtotal': amtSubtotal,
      'amt_disc': amtDisc,
      'amt_net': amtNet,
      'amt_ppn': amtPpn,
      'ppn_persen': ppnPersen,
      'ppn': ppn,
      'dt_aprv': dtAprv,
      'dt_aprv2': dtAprv2,
      'dt_rjc': dtRjc,
      'dt_rjc2': dtRjc2,
      'aprv_by': aprvBy,
      'aprv2_by': aprv2By,
      'rjc_by': rjcBy,
      'rjc2_by': rjc2By,
      'pay_term_id': payTermId,
      'pr_id': prId,
      'dept_name': deptName,
      'office_id': officeId,
      'office': office,
      'article': article,
    };
  }

  factory ApprovalPo.fromMap(Map<String, dynamic> map) {
    return ApprovalPo(
      poId: map['po_id'] ?? '',
      dtPo: parseDateTime(map['dt_po'] ?? ''),
      stat: map['stat'] ?? '',
      picId: map['pic_id'] ?? '',
      vendorId: map['vendor_id'] ?? '',
      vendorName: map['vendor_name'] ?? '',
      memoTxt: map['memo_txt'] ?? '',
      qty: map['qty'] ?? '',
      amtSubtotal: map['amt_subtotal'] ?? '',
      amtDisc: map['amt_disc'] ?? '',
      amtNet: map['amt_net'] ?? '',
      amtPpn: map['amt_ppn'] ?? '',
      ppnPersen: map['ppn_persen'] ?? '',
      ppn: map['ppn'] ?? '',
      dtAprv: parseDateTime(map['dt_aprv'] ?? ''),
      dtAprv2: parseDateTime(map['dt_aprv2'] ?? ''),
      dtRjc: parseDateTime(map['dt_rjc'] ?? ''),
      dtRjc2: parseDateTime(map['dt_rjc2'] ?? ''),
      aprvBy: map['aprv_by'] ?? '',
      aprv2By: map['aprv2_by'] ?? '',
      rjcBy: map['rjc_by'] ?? '',
      rjc2By: map['rjc2_by'] ?? '',
      payTermId: map['pay_term_id'] ?? '',
      prId: map['pr_id'] ?? '',
      deptName: map['dept_name'] ?? '',
      officeId: map['office_id'] ?? '',
      office: map['office'] ?? '',
      article: List<ApprovalArticlePO>.from(
        map['article']?.map((x) => ApprovalArticlePO.fromMap(x)) ?? [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalPo.fromJson(String source) =>
      ApprovalPo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalPo(poId: $poId, dtPo: $dtPo, stat: $stat, picId: $picId, vendorId: $vendorId, vendorName: $vendorName, memoTxt: $memoTxt, qty: $qty, amtSubtotal: $amtSubtotal, amtDisc: $amtDisc, amtNet: $amtNet, amtPpn: $amtPpn, ppnPersen: $ppnPersen, ppn: $ppn, dtAprv: $dtAprv, dtAprv2: $dtAprv2, dtRjc: $dtRjc, dtRjc2: $dtRjc2, aprvBy: $aprvBy, aprv2By: $aprv2By, rjcBy: $rjcBy, rjc2By: $rjc2By, payTermId: $payTermId, prId: $prId, deptName: $deptName, officeId: $officeId, office: $office, article: $article)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalPo &&
        other.poId == poId &&
        other.dtPo == dtPo &&
        other.stat == stat &&
        other.picId == picId &&
        other.vendorId == vendorId &&
        other.vendorName == vendorName &&
        other.memoTxt == memoTxt &&
        other.qty == qty &&
        other.amtSubtotal == amtSubtotal &&
        other.amtDisc == amtDisc &&
        other.amtNet == amtNet &&
        other.amtPpn == amtPpn &&
        other.ppnPersen == ppnPersen &&
        other.ppn == ppn &&
        other.dtAprv == dtAprv &&
        other.dtAprv2 == dtAprv2 &&
        other.dtRjc == dtRjc &&
        other.dtRjc2 == dtRjc2 &&
        other.aprvBy == aprvBy &&
        other.aprv2By == aprv2By &&
        other.rjcBy == rjcBy &&
        other.rjc2By == rjc2By &&
        other.payTermId == payTermId &&
        other.prId == prId &&
        other.deptName == deptName &&
        other.officeId == officeId &&
        other.office == office &&
        listEquals(other.article, article);
  }

  @override
  int get hashCode {
    return poId.hashCode ^
        dtPo.hashCode ^
        stat.hashCode ^
        picId.hashCode ^
        vendorId.hashCode ^
        vendorName.hashCode ^
        memoTxt.hashCode ^
        qty.hashCode ^
        amtSubtotal.hashCode ^
        amtDisc.hashCode ^
        amtNet.hashCode ^
        amtPpn.hashCode ^
        ppnPersen.hashCode ^
        ppn.hashCode ^
        dtAprv.hashCode ^
        dtAprv2.hashCode ^
        dtRjc.hashCode ^
        dtRjc2.hashCode ^
        aprvBy.hashCode ^
        aprv2By.hashCode ^
        rjcBy.hashCode ^
        rjc2By.hashCode ^
        payTermId.hashCode ^
        prId.hashCode ^
        deptName.hashCode ^
        officeId.hashCode ^
        office.hashCode ^
        article.hashCode;
  }
}

class ApprovalArticlePO {
  final String no;
  final String office;
  final String poItem;
  final String poId;
  final String description;
  final String qty;
  final String articleId;
  final String stat;
  final String amtNet;
  final String unitMeas;
  final String unitPrice;
  final String remark;
  ApprovalArticlePO({
    required this.no,
    required this.office,
    required this.poItem,
    required this.poId,
    required this.description,
    required this.qty,
    required this.articleId,
    required this.stat,
    required this.amtNet,
    required this.unitMeas,
    required this.unitPrice,
    required this.remark,
  });

  ApprovalArticlePO copyWith({
    String? no,
    String? office,
    String? poItem,
    String? poId,
    String? description,
    String? qty,
    String? articleId,
    String? stat,
    String? amtNet,
    String? unitMeas,
    String? unitPrice,
    String? remark,
  }) {
    return ApprovalArticlePO(
      no: no ?? this.no,
      office: office ?? this.office,
      poItem: poItem ?? this.poItem,
      poId: poId ?? this.poId,
      description: description ?? this.description,
      qty: qty ?? this.qty,
      articleId: articleId ?? this.articleId,
      stat: stat ?? this.stat,
      amtNet: amtNet ?? this.amtNet,
      unitMeas: unitMeas ?? this.unitMeas,
      unitPrice: unitPrice ?? this.unitPrice,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'no': no,
      'office': office,
      'po_item': poItem,
      'po_id': poId,
      'description': description,
      'qty': qty,
      'article_id': articleId,
      'stat': stat,
      'amt_net': amtNet,
      'unit_meas': unitMeas,
      'unit_price': unitPrice,
      'remark': remark,
    };
  }

  factory ApprovalArticlePO.fromMap(Map<String, dynamic> map) {
    return ApprovalArticlePO(
      no: map['no'] ?? '',
      office: map['office'] ?? '',
      poItem: map['po_item'] ?? '',
      poId: map['po_id'] ?? '',
      description: map['description'] ?? '',
      qty: map['qty'] ?? '',
      articleId: map['article_id'] ?? '',
      stat: map['stat'] ?? '',
      amtNet: map['amt_net'] ?? '',
      unitMeas: map['unit_meas'] ?? '',
      unitPrice: map['unit_price'] ?? '',
      remark: map['remark'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalArticlePO.fromJson(String source) =>
      ApprovalArticlePO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalArticlePO(no: $no, office: $office, poItem: $poItem, poId: $poId, description: $description, qty: $qty, articleId: $articleId, stat: $stat, amtNet: $amtNet, unitMeas: $unitMeas, unitPrice: $unitPrice, remark: $remark)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApprovalArticlePO &&
        other.no == no &&
        other.office == office &&
        other.poItem == poItem &&
        other.poId == poId &&
        other.description == description &&
        other.qty == qty &&
        other.articleId == articleId &&
        other.stat == stat &&
        other.amtNet == amtNet &&
        other.unitMeas == unitMeas &&
        other.unitPrice == unitPrice &&
        other.remark == remark;
  }

  @override
  int get hashCode {
    return no.hashCode ^
        office.hashCode ^
        poItem.hashCode ^
        poId.hashCode ^
        description.hashCode ^
        qty.hashCode ^
        articleId.hashCode ^
        stat.hashCode ^
        amtNet.hashCode ^
        unitMeas.hashCode ^
        unitPrice.hashCode ^
        remark.hashCode;
  }
}
