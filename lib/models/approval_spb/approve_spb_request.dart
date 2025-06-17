import 'dart:convert';

class ApproveSpbRequest {
  final String idSpb;
  final String typeAprv;
  ApproveSpbRequest({required this.idSpb, required this.typeAprv});

  ApproveSpbRequest copyWith({String? idSpb, String? typeAprv}) {
    return ApproveSpbRequest(
      idSpb: idSpb ?? this.idSpb,
      typeAprv: typeAprv ?? this.typeAprv,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id_spb': idSpb, 'type_aprv': typeAprv};
  }

  factory ApproveSpbRequest.fromMap(Map<String, dynamic> map) {
    return ApproveSpbRequest(
      idSpb: map['id_spb'] ?? '',
      typeAprv: map['type_aprv'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveSpbRequest.fromJson(String source) =>
      ApproveSpbRequest.fromMap(json.decode(source));

  @override
  String toString() => 'ApproveSpbRequest(idSpb: $idSpb, typeAprv: $typeAprv)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApproveSpbRequest &&
        other.idSpb == idSpb &&
        other.typeAprv == typeAprv;
  }

  @override
  int get hashCode => idSpb.hashCode ^ typeAprv.hashCode;
}
