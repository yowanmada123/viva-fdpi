import 'dart:convert';

class Vendor {
  final String vendorId;
  final String vendorName;
  Vendor({required this.vendorId, required this.vendorName});

  Vendor copyWith({String? vendorId, String? vendorName}) {
    return Vendor(
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
    );
  }

  Map<String, dynamic> toMap() {
    return {'vendor_id': vendorId, 'vendor_name': vendorName};
  }

  factory Vendor.fromMap(Map<String, dynamic> map) {
    return Vendor(
      vendorId: map['vendor_id'] ?? '',
      vendorName: map['vendor_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Vendor.fromJson(String source) => Vendor.fromMap(json.decode(source));

  @override
  String toString() => 'Vendor(vendorId: $vendorId, vendorName: $vendorName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vendor &&
        other.vendorId == vendorId &&
        other.vendorName == vendorName;
  }

  @override
  int get hashCode => vendorId.hashCode ^ vendorName.hashCode;
}
