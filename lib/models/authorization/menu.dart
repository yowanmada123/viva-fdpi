import 'dart:convert';

class Menu {
  final String entity_id;
  final String appl_id;
  final String group_id;
  final String menu_header_caption;
  final String menu_header_path;
  final String menu_header_id;
  final String icon;
  final List<SubMenu> submenus;
  Menu({
    required this.entity_id,
    required this.appl_id,
    required this.group_id,
    required this.menu_header_caption,
    required this.menu_header_path,
    required this.menu_header_id,
    required this.icon,
    required this.submenus,
  });

  Menu copyWith({
    String? entity_id,
    String? appl_id,
    String? group_id,
    String? menu_header_caption,
    String? menu_header_path,
    String? menu_header_id,
    String? icon,
    List<SubMenu>? submenus,
  }) {
    return Menu(
      entity_id: entity_id ?? this.entity_id,
      appl_id: appl_id ?? this.appl_id,
      group_id: group_id ?? this.group_id,
      menu_header_caption: menu_header_caption ?? this.menu_header_caption,
      menu_header_path: menu_header_path ?? this.menu_header_path,
      menu_header_id: menu_header_id ?? this.menu_header_id,
      icon: icon ?? this.icon,
      submenus: submenus ?? this.submenus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'entity_id': entity_id,
      'appl_id': appl_id,
      'group_id': group_id,
      'menu_header_caption': menu_header_caption,
      'menu_header_path': menu_header_path,
      'menu_header_id': menu_header_id,
      'icon': icon,
      'submenus': submenus,
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      entity_id: map['entity_id'] ?? '',
      appl_id: map['appl_id'] ?? '',
      group_id: map['group_id'] ?? '',
      menu_header_caption: map['menu_header_caption'] ?? '',
      menu_header_path: map['menu_header_path'] ?? '',
      menu_header_id: map['menu_header_id'] ?? '',
      icon: map['icon'] ?? '',
      submenus: List.from(map['submenus'].map((e) => SubMenu.fromMap(e))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Menu(entity_id: $entity_id, appl_id: $appl_id, group_id: $group_id, menu_header_caption: $menu_header_caption, menu_header_path: $menu_header_path, menu_header_id: $menu_header_id, icon: $icon, submenus: $submenus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Menu &&
        other.entity_id == entity_id &&
        other.appl_id == appl_id &&
        other.group_id == group_id &&
        other.menu_header_caption == menu_header_caption &&
        other.menu_header_path == menu_header_path &&
        other.menu_header_id == menu_header_id &&
        other.icon == icon &&
        other.submenus == submenus;
  }

  @override
  int get hashCode {
    return entity_id.hashCode ^
        appl_id.hashCode ^
        group_id.hashCode ^
        menu_header_caption.hashCode ^
        menu_header_path.hashCode ^
        menu_header_id.hashCode ^
        icon.hashCode ^
        submenus.hashCode;
  }
}

class SubMenu {
  final String entity_id;
  final String appl_id;
  final String menu_id;
  final String seq_id;
  final String menu_caption;
  final String route_path;
  SubMenu({
    required this.entity_id,
    required this.appl_id,
    required this.menu_id,
    required this.seq_id,
    required this.menu_caption,
    required this.route_path,
  });

  SubMenu copyWith({
    String? entity_id,
    String? appl_id,
    String? menu_id,
    String? seq_id,
    String? menu_caption,
    String? route_path,
  }) {
    return SubMenu(
      entity_id: entity_id ?? this.entity_id,
      appl_id: appl_id ?? this.appl_id,
      menu_id: menu_id ?? this.menu_id,
      seq_id: seq_id ?? this.seq_id,
      menu_caption: menu_caption ?? this.menu_caption,
      route_path: route_path ?? this.route_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'entity_id': entity_id,
      'appl_id': appl_id,
      'menu_id': menu_id,
      'seq_id': seq_id,
      'menu_caption': menu_caption,
      'route_path': route_path,
    };
  }

  factory SubMenu.fromMap(Map<String, dynamic> map) {
    return SubMenu(
      entity_id: map['entity_id'] ?? '',
      appl_id: map['appl_id'] ?? '',
      menu_id: map['menu_id'] ?? '',
      seq_id: map['seq_id'] ?? '',
      menu_caption: map['menu_caption'] ?? '',
      route_path: map['route_path'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubMenu.fromJson(String source) =>
      SubMenu.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubMenu(entity_id: $entity_id, appl_id: $appl_id, menu_id: $menu_id, seq_id: $seq_id, menu_caption: $menu_caption, route_path: $route_path)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubMenu &&
        other.entity_id == entity_id &&
        other.appl_id == appl_id &&
        other.menu_id == menu_id &&
        other.seq_id == seq_id &&
        other.menu_caption == menu_caption &&
        other.route_path == route_path;
  }

  @override
  int get hashCode {
    return entity_id.hashCode ^
        appl_id.hashCode ^
        menu_id.hashCode ^
        seq_id.hashCode ^
        menu_caption.hashCode ^
        route_path.hashCode;
  }
}
