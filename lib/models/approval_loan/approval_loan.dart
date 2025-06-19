import 'dart:convert';

class ApprovalLoan {
  final String officeId;
  final String office;
  final String address;
  final String city;
  final String trId;
  final String trType;
  final String wTrType;
  final String kbNum;
  final String vendorId;
  final String idEmployee;
  final String dtKb;
  final String kbAmt;
  final String remark;
  final String stat;
  final String dtCreated;
  final String dtModified;
  final String userId;
  final String trIdRef;
  final String dtAprv1;
  final String userAprv1;
  final String dtAprv2;
  final String userAprv2;
  final String acNum;
  final String employeeName;
  final String vendorName;
  final String wCreatedBy;
  final String wAprv1By;
  final String wAprv2By;
  ApprovalLoan({
    required this.officeId,
    required this.office,
    required this.address,
    required this.city,
    required this.trId,
    required this.trType,
    required this.wTrType,
    required this.kbNum,
    required this.vendorId,
    required this.idEmployee,
    required this.dtKb,
    required this.kbAmt,
    required this.remark,
    required this.stat,
    required this.dtCreated,
    required this.dtModified,
    required this.userId,
    required this.trIdRef,
    required this.dtAprv1,
    required this.userAprv1,
    required this.dtAprv2,
    required this.userAprv2,
    required this.acNum,
    required this.employeeName,
    required this.vendorName,
    required this.wCreatedBy,
    required this.wAprv1By,
    required this.wAprv2By,
  });

  ApprovalLoan copyWith({
    String? officeId,
    String? office,
    String? address,
    String? city,
    String? trId,
    String? trType,
    String? wTrType,
    String? kbNum,
    String? vendorId,
    String? idEmployee,
    String? dtKb,
    String? kbAmt,
    String? remark,
    String? stat,
    String? dtCreated,
    String? dtModified,
    String? userId,
    String? trIdRef,
    String? dtAprv1,
    String? userAprv1,
    String? dtAprv2,
    String? userAprv2,
    String? acNum,
    String? employeeName,
    String? vendorName,
    String? wCreatedBy,
    String? wAprv1By,
    String? wAprv2By,
  }) {
    return ApprovalLoan(
      officeId: officeId ?? this.officeId,
      office: office ?? this.office,
      address: address ?? this.address,
      city: city ?? this.city,
      trId: trId ?? this.trId,
      trType: trType ?? this.trType,
      wTrType: wTrType ?? this.wTrType,
      kbNum: kbNum ?? this.kbNum,
      vendorId: vendorId ?? this.vendorId,
      idEmployee: idEmployee ?? this.idEmployee,
      dtKb: dtKb ?? this.dtKb,
      kbAmt: kbAmt ?? this.kbAmt,
      remark: remark ?? this.remark,
      stat: stat ?? this.stat,
      dtCreated: dtCreated ?? this.dtCreated,
      dtModified: dtModified ?? this.dtModified,
      userId: userId ?? this.userId,
      trIdRef: trIdRef ?? this.trIdRef,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      userAprv1: userAprv1 ?? this.userAprv1,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      userAprv2: userAprv2 ?? this.userAprv2,
      acNum: acNum ?? this.acNum,
      employeeName: employeeName ?? this.employeeName,
      vendorName: vendorName ?? this.vendorName,
      wCreatedBy: wCreatedBy ?? this.wCreatedBy,
      wAprv1By: wAprv1By ?? this.wAprv1By,
      wAprv2By: wAprv2By ?? this.wAprv2By,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'office_id': officeId,
      'office': office,
      'address': address,
      'city': city,
      'tr_id': trId,
      'tr_type': trType,
      'w_tr_type': wTrType,
      'kb_num': kbNum,
      'vendor_id': vendorId,
      'idemployee': idEmployee,
      'dt_kb': dtKb,
      'kb_amt': kbAmt,
      'remark': remark,
      'stat': stat,
      'dt_created': dtCreated,
      'dt_modified': dtModified,
      'user_id': userId,
      'tr_id_ref': trIdRef,
      'dt_aprv1': dtAprv1,
      'user_aprv1': userAprv1,
      'dt_aprv2': dtAprv2,
      'user_aprv2': userAprv2,
      'ac_num': acNum,
      'employee_name': employeeName,
      'vendor_name': vendorName,
      'w_created_by': wCreatedBy,
      'w_aprv1_by': wAprv1By,
      'w_aprv2_by': wAprv2By,
    };
  }

  factory ApprovalLoan.fromMap(Map<String, dynamic> map) {
    return ApprovalLoan(
      officeId: map['office_id'] ?? '',
      office: map['office'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      trId: map['tr_id'] ?? '',
      trType: map['tr_type'] ?? '',
      wTrType: map['w_tr_type'] ?? '',
      kbNum: map['kb_num'] ?? '',
      vendorId: map['vendor_id'] ?? '',
      idEmployee: map['idemployee'] ?? '',
      dtKb: map['dt_kb'] ?? '',
      kbAmt: map['kb_amt'] ?? '',
      remark: map['remark'] ?? '',
      stat: map['stat'] ?? '',
      dtCreated: map['dt_created'] ?? '',
      dtModified: map['dt_modified'] ?? '',
      userId: map['user_id'] ?? '',
      trIdRef: map['tr_id_ref'] ?? '',
      dtAprv1: map['dt_aprv1'] ?? '',
      userAprv1: map['user_aprv1'] ?? '',
      dtAprv2: map['dt_aprv2'] ?? '',
      userAprv2: map['user_aprv2'] ?? '',
      acNum: map['ac_num'] ?? '',
      employeeName: map['employee_name'] ?? '',
      vendorName: map['vendor_name'] ?? '',
      wCreatedBy: map['w_created_by'] ?? '',
      wAprv1By: map['w_aprv1_by'] ?? '',
      wAprv2By: map['w_aprv2_by'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ApprovalLoan.fromJson(String source) => ApprovalLoan.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApprovalLoan(officeId: $officeId, office: $office, address: $address, city: $city, trId: $trId, trType: $trType, wTrType: $wTrType, kbNum: $kbNum, vendorId: $vendorId, idEmployee: $idEmployee, dtKb: $dtKb, kbAmt: $kbAmt, remark: $remark, stat: $stat, dtCreated: $dtCreated, dtModified: $dtModified, userId: $userId, trIdRef: $trIdRef, dtAprv1: $dtAprv1, userAprv1: $userAprv1, dtAprv2: $dtAprv2, userAprv2: $userAprv2, acNum: $acNum, employeeName: $employeeName, vendorName: $vendorName, wCreatedBy: $wCreatedBy, wAprv1By: $wAprv1By, wAprv2By: $wAprv2By)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ApprovalLoan &&
      other.officeId == officeId &&
      other.office == office &&
      other.address == address &&
      other.city == city &&
      other.trId == trId &&
      other.trType == trType &&
      other.wTrType == wTrType &&
      other.kbNum == kbNum &&
      other.vendorId == vendorId &&
      other.idEmployee == idEmployee &&
      other.dtKb == dtKb &&
      other.kbAmt == kbAmt &&
      other.remark == remark &&
      other.stat == stat &&
      other.dtCreated == dtCreated &&
      other.dtModified == dtModified &&
      other.userId == userId &&
      other.trIdRef == trIdRef &&
      other.dtAprv1 == dtAprv1 &&
      other.userAprv1 == userAprv1 &&
      other.dtAprv2 == dtAprv2 &&
      other.userAprv2 == userAprv2 &&
      other.acNum == acNum &&
      other.employeeName == employeeName &&
      other.vendorName == vendorName &&
      other.wCreatedBy == wCreatedBy &&
      other.wAprv1By == wAprv1By &&
      other.wAprv2By == wAprv2By;
  }

  @override
  int get hashCode {
    return officeId.hashCode ^
      office.hashCode ^
      address.hashCode ^
      city.hashCode ^
      trId.hashCode ^
      trType.hashCode ^
      wTrType.hashCode ^
      kbNum.hashCode ^
      vendorId.hashCode ^
      idEmployee.hashCode ^
      dtKb.hashCode ^
      kbAmt.hashCode ^
      remark.hashCode ^
      stat.hashCode ^
      dtCreated.hashCode ^
      dtModified.hashCode ^
      userId.hashCode ^
      trIdRef.hashCode ^
      dtAprv1.hashCode ^
      userAprv1.hashCode ^
      dtAprv2.hashCode ^
      userAprv2.hashCode ^
      acNum.hashCode ^
      employeeName.hashCode ^
      vendorName.hashCode ^
      wCreatedBy.hashCode ^
      wAprv1By.hashCode ^
      wAprv2By.hashCode;
  }
}