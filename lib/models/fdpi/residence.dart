// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Residence {
  final String idCluster;
  final String idSite;
  final String clusterName;
  final String houseType;
  final String houseQty;
  final String remark;
  final String stat;
  final String dateCreated;
  final String createdBy;
  final String dateModified;
  final String modifiedBy;
  final String imgCluster;
  final String imgClusterThumbnail;
  final String siteName;
  final String siteAddress;
  final String kelurahanDesa;
  final String kecamatan;
  final String postalCode;
  final String phone1;
  final String phone2;
  final String email;
  final String kaSite;
  final String idProvCity;
  final String cityName;
  final String idProvince;
  final String provinceName;
  final String? houseName;
  final String? buildingArea;
  final String? landArea;
  final String? category;

  Residence({
    required this.idCluster,
    required this.idSite,
    required this.clusterName,
    required this.houseType,
    required this.houseQty,
    required this.remark,
    required this.stat,
    required this.dateCreated,
    required this.createdBy,
    required this.dateModified,
    required this.modifiedBy,
    required this.imgCluster,
    required this.imgClusterThumbnail,
    required this.siteName,
    required this.siteAddress,
    required this.kelurahanDesa,
    required this.kecamatan,
    required this.postalCode,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.kaSite,
    required this.idProvCity,
    required this.cityName,
    required this.idProvince,
    required this.provinceName,
    this.houseName,
    this.buildingArea,
    this.landArea,
    this.category,
  });

  Residence copyWith({
    String? idCluster,
    String? idSite,
    String? clusterName,
    String? houseType,
    String? houseQty,
    String? remark,
    String? stat,
    String? dateCreated,
    String? createdBy,
    String? dateModified,
    String? modifiedBy,
    String? imgCluster,
    String? imgClusterThumbnail,
    String? siteName,
    String? siteAddress,
    String? kelurahanDesa,
    String? kecamatan,
    String? postalCode,
    String? phone1,
    String? phone2,
    String? email,
    String? kaSite,
    String? idProvCity,
    String? cityName,
    String? idProvince,
    String? provinceName,
    String? houseName,
    String? buildingArea,
    String? landArea,
    String? category,
  }) {
    return Residence(
      idCluster: idCluster ?? this.idCluster,
      idSite: idSite ?? this.idSite,
      clusterName: clusterName ?? this.clusterName,
      houseType: houseType ?? this.houseType,
      houseQty: houseQty ?? this.houseQty,
      remark: remark ?? this.remark,
      stat: stat ?? this.stat,
      dateCreated: dateCreated ?? this.dateCreated,
      createdBy: createdBy ?? this.createdBy,
      dateModified: dateModified ?? this.dateModified,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      imgCluster: imgCluster ?? this.imgCluster,
      imgClusterThumbnail: imgClusterThumbnail ?? this.imgClusterThumbnail,
      siteName: siteName ?? this.siteName,
      siteAddress: siteAddress ?? this.siteAddress,
      kelurahanDesa: kelurahanDesa ?? this.kelurahanDesa,
      kecamatan: kecamatan ?? this.kecamatan,
      postalCode: postalCode ?? this.postalCode,
      phone1: phone1 ?? this.phone1,
      phone2: phone2 ?? this.phone2,
      email: email ?? this.email,
      kaSite: kaSite ?? this.kaSite,
      idProvCity: idProvCity ?? this.idProvCity,
      cityName: cityName ?? this.cityName,
      idProvince: idProvince ?? this.idProvince,
      provinceName: provinceName ?? this.provinceName,
      houseName: houseName ?? this.houseName,
      buildingArea: buildingArea ?? this.buildingArea,
      landArea: landArea ?? this.landArea,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCluster': idCluster,
      'idSite': idSite,
      'clusterName': clusterName,
      'houseType': houseType,
      'houseQty': houseQty,
      'remark': remark,
      'stat': stat,
      'dateCreated': dateCreated,
      'createdBy': createdBy,
      'dateModified': dateModified,
      'modifiedBy': modifiedBy,
      'imgCluster': imgCluster,
      'imgClusterThumbnail': imgClusterThumbnail,
      'siteName': siteName,
      'siteAddress': siteAddress,
      'kelurahanDesa': kelurahanDesa,
      'kecamatan': kecamatan,
      'postalCode': postalCode,
      'phone1': phone1,
      'phone2': phone2,
      'email': email,
      'kaSite': kaSite,
      'idProvCity': idProvCity,
      'cityName': cityName,
      'idProvince': idProvince,
      'provinceName': provinceName,
      'houseName': houseName,
      'buildingArea': buildingArea,
      'landArea': landArea,
      'category': category,
    };
  }

  factory Residence.fromMap(Map<String, dynamic> map) {
    return Residence(
      idCluster: map['id_cluster'] ,
      idSite: map['id_site'] ,
      clusterName: map['cluster_name'] ,
      houseType: map['house_type'] ,
      houseQty: map['house_qty'] ,
      remark: map['remark'] ,
      stat: map['stat'] ,
      dateCreated: map['date_created'] ,
      createdBy: map['created_by'] ,
      dateModified: map['date_modified'] ,
      modifiedBy: map['modified_by'] ,
      imgCluster: map['img_cluster'] ,
      imgClusterThumbnail: map['img_cluster_tmb'],
      siteName: map['site_name'] ,
      siteAddress: map['site_address'] != "-" ? map['site_address'] : "",
      kelurahanDesa: map['kelurahan_desa'] ,
      kecamatan: map['kecamatan'] ,
      postalCode: map['postal_code'] ,
      phone1: map['phone1'] ,
      phone2: map['phone2'] ,
      email: map['email'] ,
      kaSite: map['ka_site'] ,
      idProvCity: map['id_prov_city'] ,
      cityName: map['city_name'] ,
      idProvince: map['id_province'] ,
      provinceName: map['province_name'] ,
      houseName: map['house_name'],
      buildingArea: map['building_area'],
      landArea: map['land_area'],
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Residence.fromJson(String source) => Residence.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Residence(idCluster: $idCluster, idSite: $idSite, clusterName: $clusterName, houseType: $houseType, houseQty: $houseQty, remark: $remark, stat: $stat, dateCreated: $dateCreated, createdBy: $createdBy, dateModified: $dateModified, modifiedBy: $modifiedBy, imgCluster: $imgCluster, imgClusterThumbnail: $imgClusterThumbnail, siteName: $siteName, siteAddress: $siteAddress, kelurahanDesa: $kelurahanDesa, kecamatan: $kecamatan, postalCode: $postalCode, phone1: $phone1, phone2: $phone2, email: $email, kaSite: $kaSite, idProvCity: $idProvCity, cityName: $cityName, idProvince: $idProvince, provinceName: $provinceName, houseName: $houseName, buildingArea: $buildingArea, landArea: $landArea, category: $category)';
  }

  @override
  bool operator ==(covariant Residence other) {
    if (identical(this, other)) return true;
  
    return 
      other.idCluster == idCluster &&
      other.idSite == idSite &&
      other.clusterName == clusterName &&
      other.houseType == houseType &&
      other.houseQty == houseQty &&
      other.remark == remark &&
      other.stat == stat &&
      other.dateCreated == dateCreated &&
      other.createdBy == createdBy &&
      other.dateModified == dateModified &&
      other.modifiedBy == modifiedBy &&
      other.imgCluster == imgCluster &&
      other.imgClusterThumbnail == imgClusterThumbnail &&
      other.siteName == siteName &&
      other.siteAddress == siteAddress &&
      other.kelurahanDesa == kelurahanDesa &&
      other.kecamatan == kecamatan &&
      other.postalCode == postalCode &&
      other.phone1 == phone1 &&
      other.phone2 == phone2 &&
      other.email == email &&
      other.kaSite == kaSite &&
      other.idProvCity == idProvCity &&
      other.cityName == cityName &&
      other.idProvince == idProvince &&
      other.provinceName == provinceName &&
      other.houseName == houseName &&
      other.buildingArea == buildingArea &&
      other.landArea == landArea &&
      other.category == category;
  }

  @override
  int get hashCode {
    return idCluster.hashCode ^
      idSite.hashCode ^
      clusterName.hashCode ^
      houseType.hashCode ^
      houseQty.hashCode ^
      remark.hashCode ^
      stat.hashCode ^
      dateCreated.hashCode ^
      createdBy.hashCode ^
      dateModified.hashCode ^
      modifiedBy.hashCode ^
      imgCluster.hashCode ^
      imgClusterThumbnail.hashCode ^
      siteName.hashCode ^
      siteAddress.hashCode ^
      kelurahanDesa.hashCode ^
      kecamatan.hashCode ^
      postalCode.hashCode ^
      phone1.hashCode ^
      phone2.hashCode ^
      email.hashCode ^
      kaSite.hashCode ^
      idProvCity.hashCode ^
      cityName.hashCode ^
      idProvince.hashCode ^
      provinceName.hashCode ^
      houseName.hashCode ^
      buildingArea.hashCode ^
      landArea.hashCode ^
      category.hashCode;
  }
}
