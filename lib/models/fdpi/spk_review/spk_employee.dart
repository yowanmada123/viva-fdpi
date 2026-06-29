import 'dart:convert';

class Employee {
  final String idUser;
  final String namaEmployee;
  final String jabatanEmployee;
  final String alamatEmployee;
  final String? phoneEmployee;
  final String? emailEmployee;

  Employee({
    required this.idUser,
    required this.namaEmployee,
    required this.jabatanEmployee,
    required this.alamatEmployee,
    this.phoneEmployee,
    this.emailEmployee,
  });

  Employee copyWith({
    String? idUser,
    String? namaEmployee,
    String? jabatanEmployee,
    String? alamatEmployee,
    String? phoneEmployee,
    String? emailEmployee,
  }) {
    return Employee(
      idUser: idUser ?? this.idUser,
      namaEmployee: namaEmployee ?? this.namaEmployee,
      jabatanEmployee: jabatanEmployee ?? this.jabatanEmployee,
      alamatEmployee: alamatEmployee ?? this.alamatEmployee,
      phoneEmployee: phoneEmployee ?? this.phoneEmployee,
      emailEmployee: emailEmployee ?? this.emailEmployee,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_user': idUser,
      'nama_employee': namaEmployee,
      'jabatan_employee': jabatanEmployee,
      'alamat_employee': alamatEmployee,
      'phone_employee': phoneEmployee,
      'email_employee': emailEmployee,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      idUser: map['id_user']?.toString() ?? '',
      namaEmployee: map['nama_employee']?.toString() ?? '',
      jabatanEmployee: map['jabatan_employee']?.toString() ?? '',
      alamatEmployee: map['alamat_employee']?.toString() ?? '',
      phoneEmployee: map['phone_employee']?.toString(),
      emailEmployee: map['email_employee']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Employee(idUser: $idUser, namaEmployee: $namaEmployee, jabatanEmployee: $jabatanEmployee, alamatEmployee: $alamatEmployee, phoneEmployee: $phoneEmployee, emailEmployee: $emailEmployee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Employee &&
        other.idUser == idUser &&
        other.namaEmployee == namaEmployee &&
        other.jabatanEmployee == jabatanEmployee &&
        other.alamatEmployee == alamatEmployee &&
        other.phoneEmployee == phoneEmployee &&
        other.emailEmployee == emailEmployee;
  }

  @override
  int get hashCode {
    return idUser.hashCode ^
        namaEmployee.hashCode ^
        jabatanEmployee.hashCode ^
        alamatEmployee.hashCode ^
        phoneEmployee.hashCode ^
        emailEmployee.hashCode;
  }
}
