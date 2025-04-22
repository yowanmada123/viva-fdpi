// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class City {
  final String idCity;
  final String idProvCity;
  final String cityName;
  final String idProvince;
  final String kemendagriProvinceCode;
  City({
    required this.idCity,
    required this.idProvCity,
    required this.cityName,
    required this.idProvince,
    required this.kemendagriProvinceCode,
  });

  City copyWith({
    String? idCity,
    String? idProvCity,
    String? cityName,
    String? idProvince,
    String? kemendagriProvinceCode,
  }) {
    return City(
      idCity: idCity ?? this.idCity,
      idProvCity: idProvCity ?? this.idProvCity,
      cityName: cityName ?? this.cityName,
      idProvince: idProvince ?? this.idProvince,
      kemendagriProvinceCode: kemendagriProvinceCode ?? this.kemendagriProvinceCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCity': idCity,
      'idProvCity': idProvCity,
      'cityName': cityName,
      'idProvince': idProvince,
      'kemendagriProvinceCode': kemendagriProvinceCode,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      idCity: map['id_city'] as String,
      idProvCity: map['id_prov_city'] as String,
      cityName: map['city_name'] as String,
      idProvince: map['id_province'] as String,
      kemendagriProvinceCode: map['kemendagri_province_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) => City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'City(idCity: $idCity, idProvCity: $idProvCity, cityName: $cityName, idProvince: $idProvince, kemendagriProvinceCode: $kemendagriProvinceCode)';
  }

  @override
  bool operator ==(covariant City other) {
    if (identical(this, other)) return true;
  
    return 
      other.idCity == idCity &&
      other.idProvCity == idProvCity &&
      other.cityName == cityName &&
      other.idProvince == idProvince &&
      other.kemendagriProvinceCode == kemendagriProvinceCode;
  }

  @override
  int get hashCode {
    return idCity.hashCode ^
      idProvCity.hashCode ^
      cityName.hashCode ^
      idProvince.hashCode ^
      kemendagriProvinceCode.hashCode;
  }
}
