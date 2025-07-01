import 'dart:convert';

import 'package:latlong2/latlong.dart';

import '../../utils/datetime_convertion.dart' show parseDateTime;

class Coordinates {
  final String idCoordinates;
  final String name;
  final String description;
  final String clusterName;
  final String commonName;
  final String buildingArea;
  final String landArea;
  final String statName;
  final DateTime? dateBuild;
  final DateTime? dateFinish;
  final String soldStatName;
  final DateTime? dateSold;
  final List<LatLng>? coordinates;
  final String color;
  final String colorName;
  final double ratio = 1000.0;

  Coordinates({
    required this.idCoordinates,
    required this.name,
    required this.description,
    required this.clusterName,
    required this.commonName,
    required this.buildingArea,
    required this.landArea,
    required this.statName,
    required this.dateBuild,
    required this.dateFinish,
    required this.soldStatName,
    required this.dateSold,
    required this.coordinates,
    required this.color,
    required this.colorName,
  });

  Coordinates copyWith({
    String? idCoordinates,
    String? name,
    String? description,
    String? clusterName,
    String? commonName,
    String? buildingArea,
    String? landArea,
    String? statName,
    DateTime? dateBuild,
    DateTime? dateFinish,
    String? soldStatName,
    DateTime? dateSold,
    List<LatLng>? coordinates,
    String? color,
    String? colorName,
  }) {
    return Coordinates(
      idCoordinates: idCoordinates ?? this.idCoordinates,
      name: name ?? this.name,
      description: description ?? this.description,
      clusterName: clusterName ?? this.clusterName,
      commonName: commonName ?? this.commonName,
      buildingArea: buildingArea ?? this.buildingArea,
      landArea: landArea ?? this.landArea,
      statName: statName ?? this.statName,
      dateBuild: dateBuild ?? this.dateBuild,
      dateFinish: dateFinish ?? this.dateFinish,
      soldStatName: soldStatName ?? this.soldStatName,
      dateSold: dateSold ?? this.dateSold,
      coordinates: coordinates ?? this.coordinates,
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
    );
  }

  static List<LatLng>? _parseCoordinates(String? coordString) {
    if (coordString == null || coordString.isEmpty || coordString == '""') {
      return null;
    }

    try {
      final double ratio = 1000.0;
      final List<dynamic> coords = jsonDecode(coordString);
      return coords
          .map((e) => LatLng(e[0].toDouble() / ratio, e[1].toDouble() / ratio))
          .toList();
    } catch (e) {
      return null;
    }
  }

  // In case in the future feature, the coordinates needs to be parse to String and multiply with 1000
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_house': idCoordinates,
      'name': name,
      'description': description,
      'cluster_name': clusterName,
      'common_name': commonName,
      'building_area': buildingArea,
      'land_area': landArea,
      'stat_name': statName,
      'date_build': dateBuild,
      'date_finish': dateFinish,
      'sold_stat_name': soldStatName,
      'date_sold': dateSold,
      'coordinates': coordinates,
      'color': color,
      'color_name': colorName,
    };
  }

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      idCoordinates: map['id_house'] ?? "",
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      clusterName: map['cluster_name'] ?? "",
      commonName: map['common_name'] ?? "",
      buildingArea: map['building_area'] ?? "",
      landArea: map['land_area'] ?? "",
      statName: map['stat_name'] ?? "",
      dateBuild: parseDateTime(map['date_build'] ?? ""),
      dateFinish: parseDateTime(map['date_finish'] ?? ""),
      soldStatName: map['sold_stat_name'] ?? "",
      dateSold: parseDateTime(map['date_sold'] ?? ""),
      coordinates: _parseCoordinates(map['coordinates'] ?? ""),
      color: map['color'] ?? "",
      colorName: map['color_name'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Coordinates.fromJson(String source) =>
      Coordinates.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coordinates(idCoordinates: $idCoordinates, name: $name, description: $description, clusterName: $clusterName, commonName: $commonName, buildingArea: $buildingArea, landArea: $landArea, statName: $statName, dateBuild: $dateBuild, dateFinish: $dateFinish, soldStatName: $soldStatName, dateSold: $dateSold, coordinates: $coordinates, color: $color, colorName: $colorName)';
  }

  @override
  bool operator ==(covariant Coordinates other) {
    if (identical(this, other)) return true;

    return other.idCoordinates == idCoordinates &&
        other.name == name &&
        other.description == description &&
        other.clusterName == clusterName &&
        other.commonName == commonName &&
        other.buildingArea == buildingArea &&
        other.landArea == landArea &&
        other.statName == statName &&
        other.dateBuild == dateBuild &&
        other.dateFinish == dateFinish &&
        other.soldStatName == soldStatName &&
        other.dateSold == dateSold &&
        other.coordinates == coordinates &&
        other.color == color &&
        other.colorName == colorName;
  }

  @override
  int get hashCode {
    return idCoordinates.hashCode ^
        name.hashCode ^
        description.hashCode ^
        clusterName.hashCode ^
        commonName.hashCode ^
        buildingArea.hashCode ^
        landArea.hashCode ^
        statName.hashCode ^
        dateBuild.hashCode ^
        dateFinish.hashCode ^
        soldStatName.hashCode ^
        dateSold.hashCode ^
        coordinates.hashCode ^
        color.hashCode ^
        colorName.hashCode;
  }
}
