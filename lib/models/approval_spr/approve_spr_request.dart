import 'dart:convert';

class ApproveSprRequest {
  final String idSpr;
  final String typeAprv;
  ApproveSprRequest({required this.idSpr, required this.typeAprv});

  ApproveSprRequest copyWith({String? idSpr, String? typeAprv}) {
    return ApproveSprRequest(
      idSpr: idSpr ?? this.idSpr,
      typeAprv: typeAprv ?? this.typeAprv,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id_spr': idSpr, 'type_aprv': typeAprv};
  }

  factory ApproveSprRequest.fromMap(Map<String, dynamic> map) {
    return ApproveSprRequest(
      idSpr: map['id_spr'] ?? '',
      typeAprv: map['type_aprv'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveSprRequest.fromJson(String source) =>
      ApproveSprRequest.fromMap(json.decode(source));

  @override
  String toString() => 'ApproveSprRequest(idSpr: $idSpr, typeAprv: $typeAprv)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApproveSprRequest &&
        other.idSpr == idSpr &&
        other.typeAprv == typeAprv;
  }

  @override
  int get hashCode => idSpr.hashCode ^ typeAprv.hashCode;
}
