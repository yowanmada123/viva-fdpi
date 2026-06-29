import 'dart:convert';

class Contractor {
  final String idVendor;
  final String namaContractor;
  final String businessName;
  final String alamatContractor;
  final String? phone;
  final String? nik;
  final String? email;
  final String? contactName;

  Contractor({
    required this.idVendor,
    required this.namaContractor,
    required this.businessName,
    required this.alamatContractor,
    this.phone,
    this.nik,
    this.email,
    this.contactName,
  });

  Contractor copyWith({
    String? idVendor,
    String? namaContractor,
    String? businessName,
    String? alamatContractor,
    String? phone,
    String? nik,
    String? email,
    String? contactName,
  }) {
    return Contractor(
      idVendor: idVendor ?? this.idVendor,
      namaContractor: namaContractor ?? this.namaContractor,
      businessName: businessName ?? this.businessName,
      alamatContractor: alamatContractor ?? this.alamatContractor,
      phone: phone ?? this.phone,
      nik: nik ?? this.nik,
      email: email ?? this.email,
      contactName: contactName ?? this.contactName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_vendor': idVendor,
      'nama_contractor': namaContractor,
      'business_name': businessName,
      'alamat_contractor': alamatContractor,
      'phone': phone,
      'nik': nik,
      'email': email,
      'contact_name': contactName,
    };
  }

  factory Contractor.fromMap(Map<String, dynamic> map) {
    return Contractor(
      idVendor: map['id_vendor']?.toString() ?? '',
      namaContractor: map['nama_contractor']?.toString() ?? '',
      businessName: map['business_name']?.toString() ?? '',
      alamatContractor: map['alamat_contractor']?.toString() ?? '',
      phone: map['phone']?.toString(),
      nik: map['nik']?.toString(),
      email: map['email']?.toString(),
      contactName: map['contact_name']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contractor.fromJson(String source) =>
      Contractor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Contractor(idVendor: $idVendor, namaContractor: $namaContractor, businessName: $businessName, alamatContractor: $alamatContractor, phone: $phone, nik: $nik, email: $email, contactName: $contactName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contractor &&
        other.idVendor == idVendor &&
        other.namaContractor == namaContractor &&
        other.businessName == businessName &&
        other.alamatContractor == alamatContractor &&
        other.phone == phone &&
        other.nik == nik &&
        other.email == email &&
        other.contactName == contactName;
  }

  @override
  int get hashCode {
    return idVendor.hashCode ^
        namaContractor.hashCode ^
        businessName.hashCode ^
        alamatContractor.hashCode ^
        phone.hashCode ^
        nik.hashCode ^
        email.hashCode ^
        contactName.hashCode;
  }
}
