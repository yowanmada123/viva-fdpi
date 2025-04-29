import 'dart:convert';

class HouseItem {
  final String id_house;
  final String id_cluster;
  final String stat;
  final String sales;
  final String buyer;
  final String date_created;
  final String created_by;
  final String date_modified;
  final String modified_by;
  final String date_build;
  final String date_finish;
  final String date_sold;
  final String house_name;
  final String active_flag;
  final String site_coordinate;
  final String building_dimension;
  final String building_area;
  final String building_area_uom;
  final String land_dimension;
  final String land_area;
  final String land_area_uom;
  final String remark;
  final String id_site;
  final String id_house_type;
  final String no_sertifikat;
  final String sold_stat;
  final int house_price;
  final String cluster_name;
  final String site_name;
  final String site_address;
  final String kelurahan_desa;
  final String kecamatan;
  final String sbk_name;
  final String common_name;
  final String category;
  final String city;
  final String province;
  final String district;
  final String village;
  final String map_color_rgb;
  final String sold_stat_name;
  final String stat_name;
  HouseItem({
    required this.id_house,
    required this.id_cluster,
    required this.stat,
    required this.sales,
    required this.buyer,
    required this.date_created,
    required this.created_by,
    required this.date_modified,
    required this.modified_by,
    required this.date_build,
    required this.date_finish,
    required this.date_sold,
    required this.house_name,
    required this.active_flag,
    required this.site_coordinate,
    required this.building_dimension,
    required this.building_area,
    required this.building_area_uom,
    required this.land_dimension,
    required this.land_area,
    required this.land_area_uom,
    required this.remark,
    required this.id_site,
    required this.id_house_type,
    required this.no_sertifikat,
    required this.sold_stat,
    required this.house_price,
    required this.cluster_name,
    required this.site_name,
    required this.site_address,
    required this.kelurahan_desa,
    required this.kecamatan,
    required this.sbk_name,
    required this.common_name,
    required this.category,
    required this.city,
    required this.province,
    required this.district,
    required this.village,
    required this.map_color_rgb,
    required this.sold_stat_name,
    required this.stat_name,
  });

  HouseItem copyWith({
    String? id_house,
    String? id_cluster,
    String? stat,
    String? sales,
    String? buyer,
    String? date_created,
    String? created_by,
    String? date_modified,
    String? modified_by,
    String? date_build,
    String? date_finish,
    String? date_sold,
    String? house_name,
    String? active_flag,
    String? site_coordinate,
    String? building_dimension,
    String? building_area,
    String? building_area_uom,
    String? land_dimension,
    String? land_area,
    String? land_area_uom,
    String? remark,
    String? id_site,
    String? id_house_type,
    String? no_sertifikat,
    String? sold_stat,
    int? house_price,
    String? cluster_name,
    String? site_name,
    String? site_address,
    String? kelurahan_desa,
    String? kecamatan,
    String? sbk_name,
    String? common_name,
    String? category,
    String? city,
    String? province,
    String? district,
    String? village,
    String? map_color_rgb,
    String? sold_stat_name,
    String? stat_name,
  }) {
    return HouseItem(
      id_house: id_house ?? this.id_house,
      id_cluster: id_cluster ?? this.id_cluster,
      stat: stat ?? this.stat,
      sales: sales ?? this.sales,
      buyer: buyer ?? this.buyer,
      date_created: date_created ?? this.date_created,
      created_by: created_by ?? this.created_by,
      date_modified: date_modified ?? this.date_modified,
      modified_by: modified_by ?? this.modified_by,
      date_build: date_build ?? this.date_build,
      date_finish: date_finish ?? this.date_finish,
      date_sold: date_sold ?? this.date_sold,
      house_name: house_name ?? this.house_name,
      active_flag: active_flag ?? this.active_flag,
      site_coordinate: site_coordinate ?? this.site_coordinate,
      building_dimension: building_dimension ?? this.building_dimension,
      building_area: building_area ?? this.building_area,
      building_area_uom: building_area_uom ?? this.building_area_uom,
      land_dimension: land_dimension ?? this.land_dimension,
      land_area: land_area ?? this.land_area,
      land_area_uom: land_area_uom ?? this.land_area_uom,
      remark: remark ?? this.remark,
      id_site: id_site ?? this.id_site,
      id_house_type: id_house_type ?? this.id_house_type,
      no_sertifikat: no_sertifikat ?? this.no_sertifikat,
      sold_stat: sold_stat ?? this.sold_stat,
      house_price: house_price ?? this.house_price,
      cluster_name: cluster_name ?? this.cluster_name,
      site_name: site_name ?? this.site_name,
      site_address: site_address ?? this.site_address,
      kelurahan_desa: kelurahan_desa ?? this.kelurahan_desa,
      kecamatan: kecamatan ?? this.kecamatan,
      sbk_name: sbk_name ?? this.sbk_name,
      common_name: common_name ?? this.common_name,
      category: category ?? this.category,
      city: city ?? this.city,
      province: province ?? this.province,
      district: district ?? this.district,
      village: village ?? this.village,
      map_color_rgb: map_color_rgb ?? this.map_color_rgb,
      sold_stat_name: sold_stat_name ?? this.sold_stat_name,
      stat_name: stat_name ?? this.stat_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_house': id_house,
      'id_cluster': id_cluster,
      'stat': stat,
      'sales': sales,
      'buyer': buyer,
      'date_created': date_created,
      'created_by': created_by,
      'date_modified': date_modified,
      'modified_by': modified_by,
      'date_build': date_build,
      'date_finish': date_finish,
      'date_sold': date_sold,
      'house_name': house_name,
      'active_flag': active_flag,
      'site_coordinate': site_coordinate,
      'building_dimension': building_dimension,
      'building_area': building_area,
      'building_area_uom': building_area_uom,
      'land_dimension': land_dimension,
      'land_area': land_area,
      'land_area_uom': land_area_uom,
      'remark': remark,
      'id_site': id_site,
      'id_house_type': id_house_type,
      'no_sertifikat': no_sertifikat,
      'sold_stat': sold_stat,
      'house_price': house_price,
      'cluster_name': cluster_name,
      'site_name': site_name,
      'site_address': site_address,
      'kelurahan_desa': kelurahan_desa,
      'kecamatan': kecamatan,
      'sbk_name': sbk_name,
      'common_name': common_name,
      'category': category,
      'city': city,
      'province': province,
      'district': district,
      'village': village,
      'map_color_rgb': map_color_rgb,
      'sold_stat_name': sold_stat_name,
      'stat_name': stat_name,
    };
  }

  factory HouseItem.fromMap(Map<String, dynamic> map) {
    return HouseItem(
      id_house: map['id_house'] ?? '',
      id_cluster: map['id_cluster'] ?? '',
      stat: map['stat'] ?? '',
      sales: map['sales'] ?? '',
      buyer: map['buyer'] ?? '',
      date_created: map['date_created'] ?? '',
      created_by: map['created_by'] ?? '',
      date_modified: map['date_modified'] ?? '',
      modified_by: map['modified_by'] ?? '',
      date_build: map['date_build'] ?? '',
      date_finish: map['date_finish'] ?? '',
      date_sold: map['date_sold'] ?? '',
      house_name: map['house_name'] ?? '',
      active_flag: map['active_flag'] ?? '',
      site_coordinate: map['site_coordinate'] ?? '',
      building_dimension: map['building_dimension'] ?? '',
      building_area: map['building_area'] ?? '',
      building_area_uom: map['building_area_uom'] ?? '',
      land_dimension: map['land_dimension'] ?? '',
      land_area: map['land_area'] ?? '',
      land_area_uom: map['land_area_uom'] ?? '',
      remark: map['remark'] ?? '',
      id_site: map['id_site'] ?? '',
      id_house_type: map['id_house_type'] ?? '',
      no_sertifikat: map['no_sertifikat'] ?? '',
      sold_stat: map['sold_stat'] ?? '',
      house_price: map['house_price']?.toInt() ?? 0,
      cluster_name: map['cluster_name'] ?? '',
      site_name: map['site_name'] ?? '',
      site_address: map['site_address'] ?? '',
      kelurahan_desa: map['kelurahan_desa'] ?? '',
      kecamatan: map['kecamatan'] ?? '',
      sbk_name: map['sbk_name'] ?? '',
      common_name: map['common_name'] ?? '',
      category: map['category'] ?? '',
      city: map['city'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      village: map['village'] ?? '',
      map_color_rgb: map['map_color_rgb'] ?? '',
      sold_stat_name: map['sold_stat_name'] ?? '',
      stat_name: map['stat_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HouseItem.fromJson(String source) =>
      HouseItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HouseItem(id_house: $id_house, id_cluster: $id_cluster, stat: $stat, sales: $sales, buyer: $buyer, date_created: $date_created, created_by: $created_by, date_modified: $date_modified, modified_by: $modified_by, date_build: $date_build, date_finish: $date_finish, date_sold: $date_sold, house_name: $house_name, active_flag: $active_flag, site_coordinate: $site_coordinate, building_dimension: $building_dimension, building_area: $building_area, building_area_uom: $building_area_uom, land_dimension: $land_dimension, land_area: $land_area, land_area_uom: $land_area_uom, remark: $remark, id_site: $id_site, id_house_type: $id_house_type, no_sertifikat: $no_sertifikat, sold_stat: $sold_stat, house_price: $house_price, cluster_name: $cluster_name, site_name: $site_name, site_address: $site_address, kelurahan_desa: $kelurahan_desa, kecamatan: $kecamatan, sbk_name: $sbk_name, common_name: $common_name, category: $category, city: $city, province: $province, district: $district, village: $village, map_color_rgb: $map_color_rgb, sold_stat_name: $sold_stat_name, stat_name: $stat_name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HouseItem &&
        other.id_house == id_house &&
        other.id_cluster == id_cluster &&
        other.stat == stat &&
        other.sales == sales &&
        other.buyer == buyer &&
        other.date_created == date_created &&
        other.created_by == created_by &&
        other.date_modified == date_modified &&
        other.modified_by == modified_by &&
        other.date_build == date_build &&
        other.date_finish == date_finish &&
        other.date_sold == date_sold &&
        other.house_name == house_name &&
        other.active_flag == active_flag &&
        other.site_coordinate == site_coordinate &&
        other.building_dimension == building_dimension &&
        other.building_area == building_area &&
        other.building_area_uom == building_area_uom &&
        other.land_dimension == land_dimension &&
        other.land_area == land_area &&
        other.land_area_uom == land_area_uom &&
        other.remark == remark &&
        other.id_site == id_site &&
        other.id_house_type == id_house_type &&
        other.no_sertifikat == no_sertifikat &&
        other.sold_stat == sold_stat &&
        other.house_price == house_price &&
        other.cluster_name == cluster_name &&
        other.site_name == site_name &&
        other.site_address == site_address &&
        other.kelurahan_desa == kelurahan_desa &&
        other.kecamatan == kecamatan &&
        other.sbk_name == sbk_name &&
        other.common_name == common_name &&
        other.category == category &&
        other.city == city &&
        other.province == province &&
        other.district == district &&
        other.village == village &&
        other.map_color_rgb == map_color_rgb &&
        other.sold_stat_name == sold_stat_name &&
        other.stat_name == stat_name;
  }

  @override
  int get hashCode {
    return id_house.hashCode ^
        id_cluster.hashCode ^
        stat.hashCode ^
        sales.hashCode ^
        buyer.hashCode ^
        date_created.hashCode ^
        created_by.hashCode ^
        date_modified.hashCode ^
        modified_by.hashCode ^
        date_build.hashCode ^
        date_finish.hashCode ^
        date_sold.hashCode ^
        house_name.hashCode ^
        active_flag.hashCode ^
        site_coordinate.hashCode ^
        building_dimension.hashCode ^
        building_area.hashCode ^
        building_area_uom.hashCode ^
        land_dimension.hashCode ^
        land_area.hashCode ^
        land_area_uom.hashCode ^
        remark.hashCode ^
        id_site.hashCode ^
        id_house_type.hashCode ^
        no_sertifikat.hashCode ^
        sold_stat.hashCode ^
        house_price.hashCode ^
        cluster_name.hashCode ^
        site_name.hashCode ^
        site_address.hashCode ^
        kelurahan_desa.hashCode ^
        kecamatan.hashCode ^
        sbk_name.hashCode ^
        common_name.hashCode ^
        category.hashCode ^
        city.hashCode ^
        province.hashCode ^
        district.hashCode ^
        village.hashCode ^
        map_color_rgb.hashCode ^
        sold_stat_name.hashCode ^
        stat_name.hashCode;
  }
}
