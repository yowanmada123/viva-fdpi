import 'dart:convert';

class HouseItemSpk {
  final String idSite;
  final String idCluster;
  final String idHouse;
  final String houseName;
  final String activeFlag;
  final String buildingArea;
  final String landArea;
  final String remark;
  final String idHouseType;
  final String soldStat;
  final String housePrice;

  HouseItemSpk({
    required this.idSite,
    required this.idCluster,
    required this.idHouse,
    required this.houseName,
    required this.activeFlag,
    required this.buildingArea,
    required this.landArea,
    required this.remark,
    required this.idHouseType,
    required this.soldStat,
    required this.housePrice,
  });

  HouseItemSpk copyWith({
    String? idSite,
    String? idCluster,
    String? idHouse,
    String? houseName,
    String? activeFlag,
    String? buildingArea,
    String? landArea,
    String? remark,
    String? idHouseType,
    String? soldStat,
    String? housePrice,
  }) {
    return HouseItemSpk(
      idSite: idSite ?? this.idSite,
      idCluster: idCluster ?? this.idCluster,
      idHouse: idHouse ?? this.idHouse,
      houseName: houseName ?? this.houseName,
      activeFlag: activeFlag ?? this.activeFlag,
      buildingArea: buildingArea ?? this.buildingArea,
      landArea: landArea ?? this.landArea,
      remark: remark ?? this.remark,
      idHouseType: idHouseType ?? this.idHouseType,
      soldStat: soldStat ?? this.soldStat,
      housePrice: housePrice ?? this.housePrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_site': idSite,
      'id_cluster': idCluster,
      'id_house': idHouse,
      'house_name': houseName,
      'active_flag': activeFlag,
      'building_area': buildingArea,
      'land_area': landArea,
      'remark': remark,
      'id_house_type': idHouseType,
      'sold_stat': soldStat,
      'house_price': housePrice,
    };
  }

  factory HouseItemSpk.fromMap(Map<String, dynamic> map) {
    return HouseItemSpk(
      idSite: map['id_site'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      idHouse: map['id_house'] ?? '',
      houseName: map['house_name'] ?? '',
      activeFlag: map['active_flag'] ?? '',
      buildingArea: map['building_area'] ?? '',
      landArea: map['land_area'] ?? '',
      remark: map['remark'] ?? '',
      idHouseType: map['id_house_type'] ?? '',
      soldStat: map['sold_stat'] ?? '',
      housePrice: map['house_price'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseItemSpk.fromJson(String source) =>
      HouseItemSpk.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseItemSpk(idSite: $idSite, idCluster: $idCluster, idHouse: $idHouse, houseName: $houseName, activeFlag: $activeFlag, buildingArea: $buildingArea, landArea: $landArea, remark: $remark, idHouseType: $idHouseType, soldStat: $soldStat, housePrice: $housePrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseItemSpk &&
        other.idSite == idSite &&
        other.idCluster == idCluster &&
        other.idHouse == idHouse &&
        other.houseName == houseName &&
        other.activeFlag == activeFlag &&
        other.buildingArea == buildingArea &&
        other.landArea == landArea &&
        other.remark == remark &&
        other.idHouseType == idHouseType &&
        other.soldStat == soldStat &&
        other.housePrice == housePrice;
  }

  @override
  int get hashCode {
    return idSite.hashCode ^
        idCluster.hashCode ^
        idHouse.hashCode ^
        houseName.hashCode ^
        activeFlag.hashCode ^
        buildingArea.hashCode ^
        landArea.hashCode ^
        remark.hashCode ^
        idHouseType.hashCode ^
        soldStat.hashCode ^
        housePrice.hashCode;
  }
}
