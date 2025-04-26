import 'dart:convert';

class Bank {
  final String bank_name;
  Bank({required this.bank_name});

  Bank copyWith({String? bank_name}) {
    return Bank(bank_name: bank_name ?? this.bank_name);
  }

  Map<String, dynamic> toMap() {
    return {'bank_name': bank_name};
  }

  factory Bank.fromMap(Map<String, dynamic> map) {
    return Bank(bank_name: map['bank_name'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory Bank.fromJson(String source) => Bank.fromMap(json.decode(source));

  @override
  String toString() => 'Bank(bank_name: $bank_name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bank && other.bank_name == bank_name;
  }

  @override
  int get hashCode => bank_name.hashCode;
}
