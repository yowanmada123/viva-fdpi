import 'dart:convert';

class LoanType {
  final String key_code;
  final String str1;
  final String str2;
  final String int1;
  final String int2;
  final String str3;
  final String str4;

  LoanType({
    required this.key_code,
    required this.str1,
    required this.str2,
    required this.int1,
    required this.int2,
    required this.str3,
    required this.str4,
  });

  LoanType copyWith({
    String? keyCode,
    String? str1,
    String? str2,
    String? int1,
    String? int2,
    String? str3,
    String? str4,
  }) {
    return LoanType(
      key_code: keyCode ?? this.key_code,
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
      'key_code': key_code,
      'str1': str1,
      'str2': str2,
      'int1': int1,
      'int2': int2,
      'str3': str3,
      'str4': str4,
    };
  }

  factory LoanType.fromMap(Map<String, dynamic> map) {
    return LoanType(
      key_code: map['key_code'] ?? '',
      str1: map['str1'] ?? '',
      str2: map['str2'] ?? '',
      int1: map['int1'] ?? '',
      int2: map['int2'] ?? '',
      str3: map['str3'] ?? '',
      str4: map['str4'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanType.fromJson(String source) =>
      LoanType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoanType(key_code: $key_code, str1: $str1, str2: $str2, int1: $int1, int2: $int2, str3: $str3, str4: $str4)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanType &&
        other.key_code == key_code &&
        other.str1 == str1 &&
        other.str2 == str2 &&
        other.int1 == int1 &&
        other.int2 == int2 &&
        other.str3 == str3 &&
        other.str4 == str4;
  }

  @override
  int get hashCode {
    return key_code.hashCode ^
        str1.hashCode ^
        str2.hashCode ^
        int1.hashCode ^
        int2.hashCode ^
        str3.hashCode ^
        str4.hashCode;
  }
}
