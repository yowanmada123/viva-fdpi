import 'dart:convert';

class Spr {
  final String idSpr;

  /// FIELD BARU
  final String namaCustomer;
  final String orderDate;
  final String payMethod;
  final String bonus;
  final String addOn;

  final String idSite;
  final String idCluster;
  final String idHouseUnit;
  final String orderAmt;
  final String namaSales;
  final String status;

  final String remark;
  final String dtAprv1;
  final String aprv1By;
  final String dtReject;
  final String rejectBy;

  final String siteName;
  final String clusterName;
  final String remarkCluster;
  final String houseName;
  final String commonName;
  final String sbkName;
  final String category;

  final String wCreatedBy;
  final String wAprv1By;
  final String wReject1By;

  Spr({
    required this.idSpr,

    /// FIELD BARU
    required this.namaCustomer,
    required this.orderDate,
    required this.payMethod,
    required this.bonus,
    required this.addOn,

    required this.idSite,
    required this.idCluster,
    required this.idHouseUnit,
    required this.orderAmt,
    required this.namaSales,
    required this.status,
    required this.remark,
    required this.dtAprv1,
    required this.aprv1By,
    required this.dtReject,
    required this.rejectBy,
    required this.siteName,
    required this.clusterName,
    required this.remarkCluster,
    required this.houseName,
    required this.commonName,
    required this.sbkName,
    required this.category,
    required this.wCreatedBy,
    required this.wAprv1By,
    required this.wReject1By,
  });

  Spr copyWith({
    String? idSpr,
    String? namaCustomer,
    String? orderDate,
    String? payMethod,
    String? bonus,
    String? addOn,
    String? idSite,
    String? idCluster,
    String? idHouseUnit,
    String? orderAmt,
    String? namaSales,
    String? status,
    String? remark,
    String? dtAprv1,
    String? aprv1By,
    String? dtReject,
    String? rejectBy,
    String? siteName,
    String? clusterName,
    String? remarkCluster,
    String? houseName,
    String? commonName,
    String? sbkName,
    String? category,
    String? wCreatedBy,
    String? wAprv1By,
    String? wReject1By,
  }) {
    return Spr(
      idSpr: idSpr ?? this.idSpr,
      namaCustomer: namaCustomer ?? this.namaCustomer,
      orderDate: orderDate ?? this.orderDate,
      payMethod: payMethod ?? this.payMethod,
      bonus: bonus ?? this.bonus,
      addOn: addOn ?? this.addOn,
      idSite: idSite ?? this.idSite,
      idCluster: idCluster ?? this.idCluster,
      idHouseUnit: idHouseUnit ?? this.idHouseUnit,
      orderAmt: orderAmt ?? this.orderAmt,
      namaSales: namaSales ?? this.namaSales,
      status: status ?? this.status,
      remark: remark ?? this.remark,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      aprv1By: aprv1By ?? this.aprv1By,
      dtReject: dtReject ?? this.dtReject,
      rejectBy: rejectBy ?? this.rejectBy,
      siteName: siteName ?? this.siteName,
      clusterName: clusterName ?? this.clusterName,
      remarkCluster: remarkCluster ?? this.remarkCluster,
      houseName: houseName ?? this.houseName,
      commonName: commonName ?? this.commonName,
      sbkName: sbkName ?? this.sbkName,
      category: category ?? this.category,
      wCreatedBy: wCreatedBy ?? this.wCreatedBy,
      wAprv1By: wAprv1By ?? this.wAprv1By,
      wReject1By: wReject1By ?? this.wReject1By,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_spr': idSpr,
      'nama_customer': namaCustomer,
      'order_date': orderDate,
      'pay_method': payMethod,
      'bonus': bonus,
      'add_on': addOn,
      'id_site': idSite,
      'id_cluster': idCluster,
      'id_house_unit': idHouseUnit,
      'order_amt': orderAmt,
      'nama_sales': namaSales,
      'status': status,
      'remark': remark,
      'dt_aprv1': dtAprv1,
      'aprv1_by': aprv1By,
      'dt_reject': dtReject,
      'reject_by': rejectBy,
      'site_name': siteName,
      'cluster_name': clusterName,
      'remark_cluster': remarkCluster,
      'house_name': houseName,
      'common_name': commonName,
      'sbk_name': sbkName,
      'category': category,
      'w_created_by': wCreatedBy,
      'w_aprv1_by': wAprv1By,
      'w_reject1_by': wReject1By,
    };
  }

  factory Spr.fromMap(Map<String, dynamic> map) {
    return Spr(
      idSpr: map['id_spr'] ?? '',
      namaCustomer: map['nama_customer'] ?? '',
      orderDate: map['order_date'] ?? '',
      payMethod: map['pay_method'] ?? '',
      bonus: map['bonus'] ?? '',
      addOn: map['add_on'] ?? '',
      idSite: map['id_site'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      idHouseUnit: map['id_house_unit'] ?? '',
      orderAmt: map['order_amt'] ?? '',
      namaSales: map['nama_sales'] ?? '',
      status: map['status'] ?? '',
      remark: map['remark'] ?? '',
      dtAprv1: map['dt_aprv1'] ?? '',
      aprv1By: map['aprv1_by'] ?? '',
      dtReject: map['dt_reject'] ?? '',
      rejectBy: map['reject_by'] ?? '',
      siteName: map['site_name'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      remarkCluster: map['remark_cluster'] ?? '',
      houseName: map['house_name'] ?? '',
      commonName: map['common_name'] ?? '',
      sbkName: map['sbk_name'] ?? '',
      category: map['category'] ?? '',
      wCreatedBy: map['w_created_by'] ?? '',
      wAprv1By: map['w_aprv1_by'] ?? '',
      wReject1By: map['w_reject1_by'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Spr.fromJson(String source) => Spr.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Spr(idSpr: $idSpr, namaCustomer: $namaCustomer, namaSales: $namaSales, houseName: $houseName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Spr &&
        other.idSpr == idSpr &&
        other.namaCustomer == namaCustomer &&
        other.orderDate == orderDate &&
        other.payMethod == payMethod &&
        other.bonus == bonus &&
        other.addOn == addOn &&
        other.idSite == idSite &&
        other.idCluster == idCluster &&
        other.idHouseUnit == idHouseUnit &&
        other.orderAmt == orderAmt &&
        other.namaSales == namaSales &&
        other.status == status &&
        other.remark == remark &&
        other.dtAprv1 == dtAprv1 &&
        other.aprv1By == aprv1By &&
        other.dtReject == dtReject &&
        other.rejectBy == rejectBy &&
        other.siteName == siteName &&
        other.clusterName == clusterName &&
        other.remarkCluster == remarkCluster &&
        other.houseName == houseName &&
        other.commonName == commonName &&
        other.sbkName == sbkName &&
        other.category == category &&
        other.wCreatedBy == wCreatedBy &&
        other.wAprv1By == wAprv1By &&
        other.wReject1By == wReject1By;
  }

  @override
  int get hashCode {
    return idSpr.hashCode ^
        namaCustomer.hashCode ^
        orderDate.hashCode ^
        payMethod.hashCode ^
        bonus.hashCode ^
        addOn.hashCode ^
        idSite.hashCode ^
        idCluster.hashCode ^
        idHouseUnit.hashCode ^
        orderAmt.hashCode ^
        namaSales.hashCode ^
        status.hashCode ^
        remark.hashCode ^
        dtAprv1.hashCode ^
        aprv1By.hashCode ^
        dtReject.hashCode ^
        rejectBy.hashCode ^
        siteName.hashCode ^
        clusterName.hashCode ^
        remarkCluster.hashCode ^
        houseName.hashCode ^
        commonName.hashCode ^
        sbkName.hashCode ^
        category.hashCode ^
        wCreatedBy.hashCode ^
        wAprv1By.hashCode ^
        wReject1By.hashCode;
  }
}
