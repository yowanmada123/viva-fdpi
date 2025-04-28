import 'dart:convert';

class Site {
  final String idSite;
  final String siteName;
  final String siteAddress;
  final String kelurahanDesa;
  final String kecamatan;
  final String city;
  final String postalCode;
  final String phone1;
  final String phone2;
  final String email;
  final String remark;
  final String kaSite;
  final String stat;
  final String dateCreated;
  final String createdBy;
  final String dateModified;
  final String modifiedBy;
  final String imgSite;
  final String proyekId;
  final String cityName;
  final String province;
  final String idProvCity;
  final String idProvince;
  final String districtName;
  final String villageName;
  Site({
    required this.idSite,
    required this.siteName,
    required this.siteAddress,
    required this.kelurahanDesa,
    required this.kecamatan,
    required this.city,
    required this.postalCode,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.remark,
    required this.kaSite,
    required this.stat,
    required this.dateCreated,
    required this.createdBy,
    required this.dateModified,
    required this.modifiedBy,
    required this.imgSite,
    required this.proyekId,
    required this.cityName,
    required this.province,
    required this.idProvCity,
    required this.idProvince,
    required this.districtName,
    required this.villageName,
  });

  Site copyWith({
    String? idSite,
    String? siteName,
    String? siteAddress,
    String? kelurahanDesa,
    String? kecamatan,
    String? city,
    String? postalCode,
    String? phone1,
    String? phone2,
    String? email,
    String? remark,
    String? kaSite,
    String? stat,
    String? dateCreated,
    String? createdBy,
    String? dateModified,
    String? modifiedBy,
    String? imgSite,
    String? proyekId,
    String? cityName,
    String? province,
    String? idProvCity,
    String? idProvince,
    String? districtName,
    String? villageName,
  }) {
    return Site(
      idSite: idSite ?? this.idSite,
      siteName: siteName ?? this.siteName,
      siteAddress: siteAddress ?? this.siteAddress,
      kelurahanDesa: kelurahanDesa ?? this.kelurahanDesa,
      kecamatan: kecamatan ?? this.kecamatan,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      email: email ?? this.email,
      remark: remark ?? this.remark,
      kaSite: kaSite ?? this.kaSite,
      stat: stat ?? this.stat,
      dateCreated: dateCreated ?? this.dateCreated,
      createdBy: createdBy ?? this.createdBy,
      dateModified: dateModified ?? this.dateModified,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      imgSite: imgSite ?? this.imgSite,
      proyekId: proyekId ?? this.proyekId,
      cityName: cityName ?? this.cityName,
      province: province ?? this.province,
      idProvCity: idProvCity ?? this.idProvCity,
      idProvince: idProvince ?? this.idProvince,
      districtName: districtName ?? this.districtName,
      villageName: villageName ?? this.villageName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_site': idSite,
      'site_name': siteName,
      'site_address': siteAddress,
      'kelurahan_desa': kelurahanDesa,
      'kecamatan': kecamatan,
      'city': city,
      'postal_code': postalCode,
      'phone1': phone1,
      'phone2': phone2,
      'email': email,
      'remark': remark,
      'ka_site': kaSite,
      'stat': stat,
      'date_created': dateCreated,
      'created_by': createdBy,
      'date_modified': dateModified,
      'modified_by': modifiedBy,
      'img_site': imgSite,
      'proyek_id': proyekId,
      'city_name': cityName,
      'province': province,
      'id_prov_city': idProvCity,
      'id_province': idProvince,
      'district_name': districtName,
      'village_name': villageName,
    };
  }

  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      idSite: map['id_site'] ?? '',
      siteName: map['site_name'] ?? '',
      siteAddress: map['site_address'] ?? '',
      kelurahanDesa: map['kelurahan_desa'] ?? '',
      kecamatan: map['kecamatan'] ?? '',
      city: map['city'] ?? '',
      postalCode: map['postal_code'] ?? '',
      phone1: map['phone1'] ?? '',
      phone2: map['phone2'] ?? '',
      email: map['email'] ?? '',
      remark: map['remark'] ?? '',
      kaSite: map['ka_site'] ?? '',
      stat: map['stat'] ?? '',
      dateCreated: map['date_created'] ?? '',
      createdBy: map['created_by'] ?? '',
      dateModified: map['date_modified'] ?? '',
      modifiedBy: map['modified_by'] ?? '',
      imgSite: map['img_site'] ?? '',
      proyekId: map['proyek_id'] ?? '',
      cityName: map['city_name'] ?? '',
      province: map['province'] ?? '',
      idProvCity: map['id_prov_city'] ?? '',
      idProvince: map['id_province'] ?? '',
      districtName: map['district_name'] ?? '',
      villageName: map['village_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) => Site.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Site(idSite: $idSite, siteName: $siteName, siteAddress: $siteAddress, kelurahanDesa: $kelurahanDesa, kecamatan: $kecamatan, city: $city, postalCode: $postalCode, phone1: $phone1, phone2: $phone2, email: $email, remark: $remark, kaSite: $kaSite, stat: $stat, dateCreated: $dateCreated, createdBy: $createdBy, dateModified: $dateModified, modifiedBy: $modifiedBy, imgSite: $imgSite, proyekId: $proyekId, cityName: $cityName, province: $province, idProvCity: $idProvCity, idProvince: $idProvince, districtName: $districtName, villageName: $villageName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Site &&
        other.idSite == idSite &&
        other.siteName == siteName &&
        other.siteAddress == siteAddress &&
        other.kelurahanDesa == kelurahanDesa &&
        other.kecamatan == kecamatan &&
        other.city == city &&
        other.postalCode == postalCode &&
        other.phone1 == phone1 &&
        other.phone2 == phone2 &&
        other.email == email &&
        other.remark == remark &&
        other.kaSite == kaSite &&
        other.stat == stat &&
        other.dateCreated == dateCreated &&
        other.createdBy == createdBy &&
        other.dateModified == dateModified &&
        other.modifiedBy == modifiedBy &&
        other.imgSite == imgSite &&
        other.proyekId == proyekId &&
        other.cityName == cityName &&
        other.province == province &&
        other.idProvCity == idProvCity &&
        other.idProvince == idProvince &&
        other.districtName == districtName &&
        other.villageName == villageName;
  }

  @override
  int get hashCode {
    return idSite.hashCode ^
        siteName.hashCode ^
        siteAddress.hashCode ^
        kelurahanDesa.hashCode ^
        kecamatan.hashCode ^
        city.hashCode ^
        postalCode.hashCode ^
        phone1.hashCode ^
        phone2.hashCode ^
        email.hashCode ^
        remark.hashCode ^
        kaSite.hashCode ^
        stat.hashCode ^
        dateCreated.hashCode ^
        createdBy.hashCode ^
        dateModified.hashCode ^
        modifiedBy.hashCode ^
        imgSite.hashCode ^
        proyekId.hashCode ^
        cityName.hashCode ^
        province.hashCode ^
        idProvCity.hashCode ^
        idProvince.hashCode ^
        districtName.hashCode ^
        villageName.hashCode;
  }
}
