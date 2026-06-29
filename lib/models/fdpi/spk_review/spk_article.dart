import 'dart:convert';

class SpkArticle {
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
  final String selectPengurangan;
  final String description;

  SpkArticle({
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
    required this.selectPengurangan,
    required this.description,
  });

  factory SpkArticle.fromMap(Map<String, dynamic> map) {
    return SpkArticle(
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
      selectPengurangan: map['select_pengurangan'] ?? '',
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
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
    'select_pengurangan': selectPengurangan,
    'description': description,
  };

  String toJson() => json.encode(toMap());

  factory SpkArticle.fromJson(String source) =>
      SpkArticle.fromMap(json.decode(source));
}
