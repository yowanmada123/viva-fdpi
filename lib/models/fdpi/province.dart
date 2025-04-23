// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Province {
  String idProvince;
  String kemendagriProvinceCode;
  String province;
  Province({
    required this.idProvince,
    required this.kemendagriProvinceCode,
    required this.province,
  });

  Province copyWith({
    String? idProvince,
    String? kemendagriProvinceCode,
    String? province,
  }) {
    return Province(
      idProvince: idProvince ?? this.idProvince,
      kemendagriProvinceCode:
          kemendagriProvinceCode ?? this.kemendagriProvinceCode,
      province: province ?? this.province,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idProvince': idProvince,
      'kemendagriProvinceCode': kemendagriProvinceCode,
      'province': province,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      idProvince: map['id_province'] ?? "",
      kemendagriProvinceCode: map['kemendagri_province_code'] ?? "",
      province: map['province'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Province.fromJson(String source) =>
      Province.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Province(idProvince: $idProvince, kemendagriProvinceCode: $kemendagriProvinceCode, province: $province)';

  @override
  bool operator ==(covariant Province other) {
    if (identical(this, other)) return true;

    return other.idProvince == idProvince &&
        other.kemendagriProvinceCode == kemendagriProvinceCode &&
        other.province == province;
  }

  @override
  int get hashCode =>
      idProvince.hashCode ^ kemendagriProvinceCode.hashCode ^ province.hashCode;
}
