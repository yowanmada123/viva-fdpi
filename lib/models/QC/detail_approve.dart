import 'dart:convert';

class DetailApproveRequest {
  final String qcTransId;
  final String idQcItem;
  final String idWork;
  DetailApproveRequest({
    required this.qcTransId,
    required this.idQcItem,
    required this.idWork,
  });

  DetailApproveRequest copyWith({
    String? qcTransId,
    String? idQcItem,
    String? idWork,
  }) {
    return DetailApproveRequest(
      qcTransId: qcTransId ?? this.qcTransId,
      idQcItem: idQcItem ?? this.idQcItem,
      idWork: idWork ?? this.idWork,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'qc_trans_id': qcTransId,
      'id_qc_item': idQcItem,
      'id_work': idWork,
    };
  }

  factory DetailApproveRequest.fromMap(Map<String, dynamic> map) {
    return DetailApproveRequest(
      qcTransId: map['qc_trans_id'] ?? '',
      idQcItem: map['id_qc_item'] ?? '',
      idWork: map['id_work'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailApproveRequest.fromJson(String source) =>
      DetailApproveRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'DetailApproveRequest(qcTransId: $qcTransId, idQcItem: $idQcItem, idWork: $idWork)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailApproveRequest &&
        other.qcTransId == qcTransId &&
        other.idQcItem == idQcItem &&
        other.idWork == idWork;
  }

  @override
  int get hashCode => qcTransId.hashCode ^ idQcItem.hashCode ^ idWork.hashCode;
}

class DetailApproveResponse {
  final String remark;
  final String imgLink;
  DetailApproveResponse({required this.remark, required this.imgLink});

  DetailApproveResponse copyWith({String? remark, String? imgLink}) {
    return DetailApproveResponse(
      remark: remark ?? this.remark,
      imgLink: imgLink ?? this.imgLink,
    );
  }

  Map<String, dynamic> toMap() {
    return {'remark': remark, 'img_link': imgLink};
  }

  factory DetailApproveResponse.fromMap(Map<String, dynamic> map) {
    return DetailApproveResponse(
      remark: map['remark'] ?? '',
      imgLink: map['img_link'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailApproveResponse.fromJson(String source) =>
      DetailApproveResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'DetailApproveResponse(remark: $remark, imgLink: $imgLink)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DetailApproveResponse &&
        other.remark == remark &&
        other.imgLink == imgLink;
  }

  @override
  int get hashCode => remark.hashCode ^ imgLink.hashCode;
}
