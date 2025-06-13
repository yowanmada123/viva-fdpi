import 'dart:convert';

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
