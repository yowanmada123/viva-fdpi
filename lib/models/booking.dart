import 'dart:convert';

class Booking {
  final String bookId;
  final String namaCustomer;
  final String alamatCustomer;
  final String nomorHp;
  final String telepon;
  final String salesId;
  final String houseItem;
  final String priceList;
  final String discount;
  final String payterm;
  final String bank;
  final String expDate;
  final String status;
  final String dtCreated;
  final String createdBy;
  final DateTime? dtAprv1;
  final String aprv1By;
  final DateTime? dtAprv2;
  final String aprv2By;
  final String trType;
  final String activeFlag;
  final String idSite;
  final String siteName;
  final String idCluster;
  final String clusterName;
  final String houseName;
  Booking({
    required this.bookId,
    required this.namaCustomer,
    required this.alamatCustomer,
    required this.nomorHp,
    required this.telepon,
    required this.salesId,
    required this.houseItem,
    required this.priceList,
    required this.discount,
    required this.payterm,
    required this.bank,
    required this.expDate,
    required this.status,
    required this.dtCreated,
    required this.createdBy,
    this.dtAprv1,
    required this.aprv1By,
    this.dtAprv2,
    required this.aprv2By,
    required this.trType,
    required this.activeFlag,
    required this.idSite,
    required this.siteName,
    required this.idCluster,
    required this.clusterName,
    required this.houseName,
  });

  Booking copyWith({
    String? bookId,
    String? namaCustomer,
    String? alamatCustomer,
    String? nomorHp,
    String? telepon,
    String? salesId,
    String? houseItem,
    String? priceList,
    String? discount,
    String? payterm,
    String? bank,
    String? expDate,
    String? status,
    String? dtCreated,
    String? createdBy,
    DateTime? dtAprv1,
    String? aprv1By,
    DateTime? dtAprv2,
    String? aprv2By,
    String? trType,
    String? activeFlag,
    String? idSite,
    String? siteName,
    String? idCluster,
    String? clusterName,
    String? houseName,
  }) {
    return Booking(
      bookId: bookId ?? this.bookId,
      namaCustomer: namaCustomer ?? this.namaCustomer,
      alamatCustomer: alamatCustomer ?? this.alamatCustomer,
      nomorHp: nomorHp ?? this.nomorHp,
      telepon: telepon ?? this.telepon,
      salesId: salesId ?? this.salesId,
      houseItem: houseItem ?? this.houseItem,
      priceList: priceList ?? this.priceList,
      discount: discount ?? this.discount,
      payterm: payterm ?? this.payterm,
      bank: bank ?? this.bank,
      expDate: expDate ?? this.expDate,
      status: status ?? this.status,
      dtCreated: dtCreated ?? this.dtCreated,
      createdBy: createdBy ?? this.createdBy,
      dtAprv1: dtAprv1 ?? this.dtAprv1,
      aprv1By: aprv1By ?? this.aprv1By,
      dtAprv2: dtAprv2 ?? this.dtAprv2,
      aprv2By: aprv2By ?? this.aprv2By,
      trType: trType ?? this.trType,
      activeFlag: activeFlag ?? this.activeFlag,
      idSite: idSite ?? this.idSite,
      siteName: siteName ?? this.siteName,
      idCluster: idCluster ?? this.idCluster,
      clusterName: clusterName ?? this.clusterName,
      houseName: houseName ?? this.houseName,
    );
  }

  static DateTime? _parseDateTime(String dateTimeString) {
    try {
      if (dateTimeString == "1900-01-01 00:00:00.000") return null;
      return DateTime.parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'book_id': bookId,
      'nama_customer': namaCustomer,
      'alamat_customer': alamatCustomer,
      'nomor_hp': nomorHp,
      'telepon': telepon,
      'sales_id': salesId,
      'house_item': houseItem,
      'price_list': priceList,
      'discount': discount,
      'payterm': payterm,
      'bank': bank,
      'exp_date': expDate,
      'status': status,
      'dt_created': dtCreated,
      'created_by': createdBy,
      'dt_aprv1': dtAprv1,
      'aprv1_by': aprv1By,
      'dt_aprv2': dtAprv2,
      'aprv2_by': aprv2By,
      'tr_type': trType,
      'active_flag': activeFlag,
      'id_site': idSite,
      'site_name': siteName,
      'id_cluster': idCluster,
      'cluster_name': clusterName,
      'house_name': houseName,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      bookId: map['book_id'] ?? '',
      namaCustomer: map['nama_customer'] ?? '',
      alamatCustomer: map['alamat_customer'] ?? '',
      nomorHp: map['nomor_hp'] ?? '',
      telepon: map['telepon'] ?? '',
      salesId: map['sales_id'] ?? '',
      houseItem: map['house_item'] ?? '',
      priceList: map['price_list'] ?? '',
      discount: map['discount'] ?? '',
      payterm: map['payterm'] ?? '',
      bank: map['bank'] ?? '',
      expDate: map['exp_date'] ?? '',
      status: map['status'] ?? '',
      dtCreated: map['dt_created'] ?? '',
      createdBy: map['created_by'] ?? '',
      dtAprv1: _parseDateTime(map['dt_aprv1'] ?? ''),
      aprv1By: (map['aprv1_by'] ?? ''),
      dtAprv2: _parseDateTime(map['dt_aprv2'] ?? ''),
      aprv2By: map['aprv2_by'] ?? '',
      trType: map['tr_type'] ?? '',
      activeFlag: map['active_flag'] ?? '',
      idSite: map['id_site'] ?? '',
      siteName: map['site_name'] ?? '',
      idCluster: map['id_cluster'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      houseName: map['house_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Booking(bookId: $bookId, namaCustomer: $namaCustomer, alamatCustomer: $alamatCustomer, nomorHp: $nomorHp, telepon: $telepon, salesId: $salesId, houseItem: $houseItem, priceList: $priceList, discount: $discount, payterm: $payterm, bank: $bank, expDate: $expDate, status: $status, dtCreated: $dtCreated, createdBy: $createdBy, dtAprv1: $dtAprv1, aprv1By: $aprv1By, dtAprv2: $dtAprv2, aprv2By: $aprv2By, trType: $trType, activeFlag: $activeFlag, idSite: $idSite, siteName: $siteName, idCluster: $idCluster, clusterName: $clusterName, houseName: $houseName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Booking &&
        other.bookId == bookId &&
        other.namaCustomer == namaCustomer &&
        other.alamatCustomer == alamatCustomer &&
        other.nomorHp == nomorHp &&
        other.telepon == telepon &&
        other.salesId == salesId &&
        other.houseItem == houseItem &&
        other.priceList == priceList &&
        other.discount == discount &&
        other.payterm == payterm &&
        other.bank == bank &&
        other.expDate == expDate &&
        other.status == status &&
        other.dtCreated == dtCreated &&
        other.createdBy == createdBy &&
        other.dtAprv1 == dtAprv1 &&
        other.aprv1By == aprv1By &&
        other.dtAprv2 == dtAprv2 &&
        other.aprv2By == aprv2By &&
        other.trType == trType &&
        other.activeFlag == activeFlag &&
        other.idSite == idSite &&
        other.siteName == siteName &&
        other.idCluster == idCluster &&
        other.clusterName == clusterName &&
        other.houseName == houseName;
  }

  @override
  int get hashCode {
    return bookId.hashCode ^
        namaCustomer.hashCode ^
        alamatCustomer.hashCode ^
        nomorHp.hashCode ^
        telepon.hashCode ^
        salesId.hashCode ^
        houseItem.hashCode ^
        priceList.hashCode ^
        discount.hashCode ^
        payterm.hashCode ^
        bank.hashCode ^
        expDate.hashCode ^
        status.hashCode ^
        dtCreated.hashCode ^
        createdBy.hashCode ^
        dtAprv1.hashCode ^
        aprv1By.hashCode ^
        dtAprv2.hashCode ^
        aprv2By.hashCode ^
        trType.hashCode ^
        activeFlag.hashCode ^
        idSite.hashCode ^
        siteName.hashCode ^
        idCluster.hashCode ^
        clusterName.hashCode ^
        houseName.hashCode;
  }
}
