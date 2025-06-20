import 'dart:convert';

class ApprovalSpkArticle {
  final String idSpk;
  final String articleId;
  final String typeArticle;
  final String qcGroup;
  final String itemNum;
  final String activeFlag;
  final String dtCreated;
  final String dtModified;
  final String createBy;
  final String modifiedBy;
  final String qty;
  final String hargaSatuan;
  final String ceklist;
  final String dtCeklist;
  final String ceklistBy;
  final String uom;
  final String selectArticle;
  final String description;
  ApprovalSpkArticle({
    required this.idSpk,
    required this.articleId,
    required this.typeArticle,
    required this.qcGroup,
    required this.itemNum,
    required this.activeFlag,
    required this.dtCreated,
    required this.dtModified,
    required this.createBy,
    required this.modifiedBy,
    required this.qty,
    required this.hargaSatuan,
    required this.ceklist,
    required this.dtCeklist,
    required this.ceklistBy,
    required this.uom,
    required this.selectArticle,
    required this.description,
  });

  ApprovalSpkArticle copyWith({
    String? idSpk,
    String? articleId,
    String? typeArticle,
    String? qcGroup,
    String? itemNum,
    String? activeFlag,
    String? dtCreated,
    String? dtModified,
    String? createBy,
    String? modifiedBy,
    String? qty,
    String? hargaSatuan,
    String? ceklist,
    String? dtCeklist,
    String? ceklistBy,
    String? uom,
    String? selectArticle,
    String? description,
  }) {
    return ApprovalSpkArticle(
      idSpk: idSpk ?? this.idSpk,
      articleId: articleId ?? this.articleId,
      typeArticle: typeArticle ?? this.typeArticle,
      qcGroup: qcGroup ?? this.qcGroup,
      itemNum: itemNum ?? this.itemNum,
      activeFlag: activeFlag ?? this.activeFlag,
      dtCreated: dtCreated ?? this.dtCreated,
      dtModified: dtModified ?? this.dtModified,
      createBy: createBy ?? this.createBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      qty: qty ?? this.qty,
      hargaSatuan: hargaSatuan ?? this.hargaSatuan,
      ceklist: ceklist ?? this.ceklist,
      dtCeklist: dtCeklist ?? this.dtCeklist,
      ceklistBy: ceklistBy ?? this.ceklistBy,
      uom: uom ?? this.uom,
      selectArticle: selectArticle ?? this.selectArticle,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_spk': idSpk,
      'article_id': articleId,
      'type_article': typeArticle,
      'qc_group': qcGroup,
      'item_num': itemNum,
      'active_flag': activeFlag,
      'dt_created': dtCreated,
      'dt_modified': dtModified,
      'create_by': createBy,
      'modified_by': modifiedBy,
      'qty': qty,
      'harga_satuan': hargaSatuan,
      'ceklist': ceklist,
      'dt_ceklist': dtCeklist,
      'ceklist_by': ceklistBy,
      'uom': uom,
      'select_article': selectArticle,
      'description': description,
    };
  }

  factory ApprovalSpkArticle.fromMap(Map<String, dynamic> map) {
    return ApprovalSpkArticle(
      idSpk: map['id_spk'] ?? '',
      articleId: map['article_id'] ?? '',
      typeArticle: map['type_article'] ?? '',
      qcGroup: map['qc_group'] ?? '',
      itemNum: map['item_num'] ?? '',
      activeFlag: map['active_flag'] ?? '',
      dtCreated: map['dt_created'] ?? '',
      dtModified: map['dt_modified'] ?? '',
      createBy: map['create_by'] ?? '',
      modifiedBy: map['modified_by'] ?? '',
      qty: map['qty'] ?? '',
      hargaSatuan: map['harga_satuan'] ?? '',
      ceklist: map['ceklist'] ?? '',
      dtCeklist: map['dt_ceklist'] ?? '',
      ceklistBy: map['ceklist_by'] ?? '',
      uom: map['uom'] ?? '',
      selectArticle: map['select_article'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalSpkArticle.fromJson(String source) => ApprovalSpkArticle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalSpkArticle(idSpk: $idSpk, articleId: $articleId, typeArticle: $typeArticle, qcGroup: $qcGroup, itemNum: $itemNum, activeFlag: $activeFlag, dtCreated: $dtCreated, dtModified: $dtModified, createBy: $createBy, modifiedBy: $modifiedBy, qty: $qty, hargaSatuan: $hargaSatuan, ceklist: $ceklist, dtCeklist: $dtCeklist, ceklistBy: $ceklistBy, uom: $uom, selectArticle: $selectArticle, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApprovalSpkArticle &&
      other.idSpk == idSpk &&
      other.articleId == articleId &&
      other.typeArticle == typeArticle &&
      other.qcGroup == qcGroup &&
      other.itemNum == itemNum &&
      other.activeFlag == activeFlag &&
      other.dtCreated == dtCreated &&
      other.dtModified == dtModified &&
      other.createBy == createBy &&
      other.modifiedBy == modifiedBy &&
      other.qty == qty &&
      other.hargaSatuan == hargaSatuan &&
      other.ceklist == ceklist &&
      other.dtCeklist == dtCeklist &&
      other.ceklistBy == ceklistBy &&
      other.uom == uom &&
      other.selectArticle == selectArticle &&
      other.description == description;
  }

  @override
  int get hashCode {
    return idSpk.hashCode ^
      articleId.hashCode ^
      typeArticle.hashCode ^
      qcGroup.hashCode ^
      itemNum.hashCode ^
      activeFlag.hashCode ^
      dtCreated.hashCode ^
      dtModified.hashCode ^
      createBy.hashCode ^
      modifiedBy.hashCode ^
      qty.hashCode ^
      hargaSatuan.hashCode ^
      ceklist.hashCode ^
      dtCeklist.hashCode ^
      ceklistBy.hashCode ^
      uom.hashCode ^
      selectArticle.hashCode ^
      description.hashCode;
  }
}