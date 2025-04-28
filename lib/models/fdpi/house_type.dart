import 'dart:convert';

class HouseType {
  final String idHouseType;
  final String sbkName;
  final String commonName;
  final String buildingDimension;
  final String buildingArea;
  final String buildingAreaUom;
  final String landDimension;
  final String landArea;
  final String landAreaUom;
  final String remark;
  final String category;
  final String stat;
  final String dateCreated;
  final String createdBy;
  final String dateModified;
  final String modifiedBy;
  final String idSite;
  final String houseQty;
  final String colorMark;
  final String mapColorRgb;
  final String mapColorName;
  final String idCluster;
  final String siteName;
  HouseType({
    required this.idHouseType,
    required this.sbkName,
    required this.commonName,
    required this.buildingDimension,
    required this.buildingArea,
    required this.buildingAreaUom,
    required this.landDimension,
    required this.landArea,
    required this.landAreaUom,
    required this.remark,
    required this.category,
    required this.stat,
    required this.dateCreated,
    required this.createdBy,
    required this.dateModified,
    required this.modifiedBy,
    required this.idSite,
    required this.houseQty,
    required this.colorMark,
    required this.mapColorRgb,
    required this.mapColorName,
    required this.idCluster,
    required this.siteName,
  });

  HouseType copyWith({
    String? idHouseType,
    String? sbkName,
    String? commonName,
    String? buildingDimension,
    String? buildingArea,
    String? buildingAreaUom,
    String? landDimension,
    String? landArea,
    String? landAreaUom,
    String? remark,
    String? category,
    String? stat,
    String? dateCreated,
    String? createdBy,
    String? dateModified,
    String? modifiedBy,
    String? idSite,
    String? houseQty,
    String? colorMark,
    String? mapColorRgb,
    String? mapColorName,
    String? idCluster,
    String? siteName,
  }) {
    return HouseType(
      idHouseType: idHouseType ?? this.idHouseType,
      sbkName: sbkName ?? this.sbkName,
      commonName: commonName ?? this.commonName,
      buildingDimension: buildingDimension ?? this.buildingDimension,
      buildingArea: buildingArea ?? this.buildingArea,
      buildingAreaUom: buildingAreaUom ?? this.buildingAreaUom,
      landDimension: landDimension ?? this.landDimension,
      landArea: landArea ?? this.landArea,
      landAreaUom: landAreaUom ?? this.landAreaUom,
      remark: remark ?? this.remark,
      category: category ?? this.category,
      stat: stat ?? this.stat,
      dateCreated: dateCreated ?? this.dateCreated,
      createdBy: createdBy ?? this.createdBy,
      dateModified: dateModified ?? this.dateModified,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      idSite: idSite ?? this.idSite,
      houseQty: houseQty ?? this.houseQty,
      colorMark: colorMark ?? this.colorMark,
      mapColorRgb: mapColorRgb ?? this.mapColorRgb,
      mapColorName: mapColorName ?? this.mapColorName,
      idCluster: idCluster ?? this.idCluster,
      siteName: siteName ?? this.siteName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_house_type': idHouseType,
      'sbk_name': sbkName,
      'common_name': commonName,
      'building_dimension': buildingDimension,
      'building_area': buildingArea,
      'building_area_uom': buildingAreaUom,
      'land_dimension': landDimension,
      'land_area': landArea,
      'land_area_uom': landAreaUom,
      'remark': remark,
      'category': category,
      'stat': stat,
      'date_created': dateCreated,
      'created_by': createdBy,
      'date_modified': dateModified,
      'modified_by': modifiedBy,
      'id_site': idSite,
      'house_qty': houseQty,
      'color_mark': colorMark,
      'map_color_rgb': mapColorRgb,
      'map_color_name': mapColorName,
      'id_cluster': idCluster,
      'site_name': siteName,
    };
  }

  factory HouseType.fromMap(Map<String, dynamic> map) {
    return HouseType(
      idHouseType: map['id_house_type'] ?? '',
      sbkName: map['sbk_name'] ?? '',
      commonName: map['common_name'] ?? '',
      buildingDimension: map['building_dimension'] ?? '',
      buildingArea: map['building_area'] ?? '',
      buildingAreaUom: map['building_area_uom'] ?? '',
      landDimension: map['land_dimension'] ?? '',
      landArea: map['land_area'] ?? '',
      landAreaUom: map['land_area_uom'] ?? '',
      remark: map['remark'] ?? '',
      category: map['category'] ?? '',
      stat: map['stat'] ?? '',
      dateCreated: map['date_created'] ?? '',
      createdBy: map['created_by'] ?? '',
      dateModified: map['date_modified'] ?? '',
      modifiedBy: map['modified_by'] ?? '',
      idSite: map['id_site'] ?? '',
      houseQty: map['house_qty'] ?? '',
      colorMark: map['color_mark'] ?? '',
      mapColorRgb: map['map_color_rgb'] ?? '',
      mapColorName: map['map_color_name'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      siteName: map['site_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseType.fromJson(String source) =>
      HouseType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseType(idHouseType: $idHouseType, sbkName: $sbkName, commonName: $commonName, buildingDimension: $buildingDimension, buildingArea: $buildingArea, buildingAreaUom: $buildingAreaUom, landDimension: $landDimension, landArea: $landArea, landAreaUom: $landAreaUom, remark: $remark, category: $category, stat: $stat, dateCreated: $dateCreated, createdBy: $createdBy, dateModified: $dateModified, modifiedBy: $modifiedBy, idSite: $idSite, houseQty: $houseQty, colorMark: $colorMark, mapColorRgb: $mapColorRgb, mapColorName: $mapColorName, idCluster: $idCluster, siteName: $siteName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseType &&
        other.idHouseType == idHouseType &&
        other.sbkName == sbkName &&
        other.commonName == commonName &&
        other.buildingDimension == buildingDimension &&
        other.buildingArea == buildingArea &&
        other.buildingAreaUom == buildingAreaUom &&
        other.landDimension == landDimension &&
        other.landArea == landArea &&
        other.landAreaUom == landAreaUom &&
        other.remark == remark &&
        other.category == category &&
        other.stat == stat &&
        other.dateCreated == dateCreated &&
        other.createdBy == createdBy &&
        other.dateModified == dateModified &&
        other.modifiedBy == modifiedBy &&
        other.idSite == idSite &&
        other.houseQty == houseQty &&
        other.colorMark == colorMark &&
        other.mapColorRgb == mapColorRgb &&
        other.mapColorName == mapColorName &&
        other.idCluster == idCluster &&
        other.siteName == siteName;
  }

  @override
  int get hashCode {
    return idHouseType.hashCode ^
        sbkName.hashCode ^
        commonName.hashCode ^
        buildingDimension.hashCode ^
        buildingArea.hashCode ^
        buildingAreaUom.hashCode ^
        landDimension.hashCode ^
        landArea.hashCode ^
        landAreaUom.hashCode ^
        remark.hashCode ^
        category.hashCode ^
        stat.hashCode ^
        dateCreated.hashCode ^
        createdBy.hashCode ^
        dateModified.hashCode ^
        modifiedBy.hashCode ^
        idSite.hashCode ^
        houseQty.hashCode ^
        colorMark.hashCode ^
        mapColorRgb.hashCode ^
        mapColorName.hashCode ^
        idCluster.hashCode ^
        siteName.hashCode;
  }
}
