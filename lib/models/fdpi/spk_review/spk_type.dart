import 'dart:convert';

class SpkType {
  final String keyCode;
  final String str1;
  final String str2;
  final String int1;
  final String int2;
  final String str3;
  final String str4;

  SpkType({
    required this.keyCode,
    required this.str1,
    required this.str2,
    required this.int1,
    required this.int2,
    required this.str3,
    required this.str4,
  });

  SpkType copyWith({
    String? keyCode,
    String? str1,
    String? str2,
    String? int1,
    String? int2,
    String? str3,
    String? str4,
  }) {
    return SpkType(
      keyCode: keyCode ?? this.keyCode,
      str1: str1 ?? this.str1,
      str2: str2 ?? this.str2,
      int1: int1 ?? this.int1,
      int2: int2 ?? this.int2,
      str3: str3 ?? this.str3,
      str4: str4 ?? this.str4,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key_code': keyCode,
      'str1': str1,
      'str2': str2,
      'int1': int1,
      'int2': int2,
      'str3': str3,
      'str4': str4,
    };
  }

  factory SpkType.fromMap(Map<String, dynamic> map) {
    return SpkType(
      keyCode: map['key_code']?.toString() ?? '',
      str1: map['str1']?.toString() ?? '',
      str2: map['str2']?.toString() ?? '',
      int1: map['int1']?.toString() ?? '',
      int2: map['int2']?.toString() ?? '',
      str3: map['str3']?.toString() ?? '',
      str4: map['str4']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SpkType.fromJson(String source) =>
      SpkType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SpkType(keyCode: $keyCode, str1: $str1, str2: $str2, int1: $int1, int2: $int2, str3: $str3, str4: $str4)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SpkType &&
        other.keyCode == keyCode &&
        other.str1 == str1 &&
        other.str2 == str2 &&
        other.int1 == int1 &&
        other.int2 == int2 &&
        other.str3 == str3 &&
        other.str4 == str4;
  }

  @override
  int get hashCode {
    return keyCode.hashCode ^
        str1.hashCode ^
        str2.hashCode ^
        int1.hashCode ^
        int2.hashCode ^
        str3.hashCode ^
        str4.hashCode;
  }
}
