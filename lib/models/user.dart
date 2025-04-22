import 'dart:convert';

class User {
  final int userNum;
  final String globalID;
  final String userID2;
  final String username;
  final String rememberToken;
  final String verifiedAt;
  final String lastActive;
  final String name1;
  final String name2;
  final String name3;
  final String regNum;
  final String plant;
  final String division;
  final String dept;
  final String section;
  final String position;
  final String userLevel;
  final String location;
  final String costCTR;
  final String phone;
  final String fax;
  final String email;
  final String website;
  final String note1;
  final String note2;
  final String deployServer;
  final String activeFlag;
  final String createdDate;
  final String dtModified;
  final String createdUser;
  final String userID;
  final String deptID;
  final String waGroupID;
  final String? oldUserID;
  // final Avatar avatar;
  final String lastShiftID;
  final String idemployee;
  final String updatedAt;
  // final Avatar2 avatar2;

  User({
    required this.userNum,
    required this.globalID,
    required this.userID2,
    required this.username,
    required this.rememberToken,
    required this.verifiedAt,
    required this.lastActive,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.regNum,
    required this.plant,
    required this.division,
    required this.dept,
    required this.section,
    required this.position,
    required this.userLevel,
    required this.location,
    required this.costCTR,
    required this.phone,
    required this.fax,
    required this.email,
    required this.website,
    required this.note1,
    required this.note2,
    required this.deployServer,
    required this.activeFlag,
    required this.createdDate,
    required this.dtModified,
    required this.createdUser,
    required this.userID,
    required this.deptID,
    required this.waGroupID,
    this.oldUserID,
    // required this.avatar,
    required this.lastShiftID,
    required this.idemployee,
    required this.updatedAt,
    // required this.avatar2,
  });

  User copyWith({
    int? userNum,
    String? globalID,
    String? userID2,
    String? username,
    String? rememberToken,
    String? verifiedAt,
    String? lastActive,
    String? name1,
    String? name2,
    String? name3,
    String? regNum,
    String? plant,
    String? division,
    String? dept,
    String? section,
    String? position,
    String? userLevel,
    String? location,
    String? costCTR,
    String? phone,
    String? fax,
    String? email,
    String? website,
    String? note1,
    String? note2,
    String? deployServer,
    String? activeFlag,
    String? createdDate,
    String? dtModified,
    String? createdUser,
    String? userID,
    String? deptID,
    String? waGroupID,
    String? oldUserID,
    // Avatar? avatar,
    String? lastShiftID,
    String? idemployee,
    String? updatedAt,
    // Avatar2? avatar2,
  }) {
    return User(
      userNum: userNum ?? this.userNum,
      globalID: globalID ?? this.globalID,
      userID2: userID2 ?? this.userID2,
      username: username ?? this.username,
      rememberToken: rememberToken ?? this.rememberToken,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      lastActive: lastActive ?? this.lastActive,
      name1: name1 ?? this.name1,
      name2: name2 ?? this.name2,
      name3: name3 ?? this.name3,
      regNum: regNum ?? this.regNum,
      plant: plant ?? this.plant,
      division: division ?? this.division,
      dept: dept ?? this.dept,
      section: section ?? this.section,
      position: position ?? this.position,
      userLevel: userLevel ?? this.userLevel,
      location: location ?? this.location,
      costCTR: costCTR ?? this.costCTR,
      phone: phone ?? this.phone,
      fax: fax ?? this.fax,
      email: email ?? this.email,
      website: website ?? this.website,
      note1: note1 ?? this.note1,
      note2: note2 ?? this.note2,
      deployServer: deployServer ?? this.deployServer,
      activeFlag: activeFlag ?? this.activeFlag,
      createdDate: createdDate ?? this.createdDate,
      dtModified: dtModified ?? this.dtModified,
      createdUser: createdUser ?? this.createdUser,
      userID: userID ?? this.userID,
      deptID: deptID ?? this.deptID,
      waGroupID: waGroupID ?? this.waGroupID,
      oldUserID: oldUserID ?? this.oldUserID,
      // avatar: avatar ?? this.avatar,
      lastShiftID: lastShiftID ?? this.lastShiftID,
      idemployee: idemployee ?? this.idemployee,
      updatedAt: updatedAt ?? this.updatedAt,
      // avatar2: avatar2 ?? this.avatar2,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_num': userNum,
      'global_id': globalID,
      'user_id2': userID2,
      'username': username,
      'remember_token': rememberToken,
      'verified_at': verifiedAt,
      'last_active': lastActive,
      'name1': name1,
      'name2': name2,
      'name3': name3,
      'reg_num': regNum,
      'plant': plant,
      'division': division,
      'dept': dept,
      'section': section,
      'position': position,
      'user_level': userLevel,
      'location': location,
      'cost_ctr': costCTR,
      'phone': phone,
      'fax': fax,
      'email': email,
      'web_site': website,
      'note1': note1,
      'note2': note2,
      'deploy_server': deployServer,
      'active_flag': activeFlag,
      'created_date': createdDate,
      'dt_modified': dtModified,
      'created_user': createdUser,
      'user_id': userID,
      'dept_id': deptID,
      'wa_group_id': waGroupID,
      'old_userID': oldUserID,
      // 'avatar': avatar.toMap(),
      'last_shift_id': lastShiftID,
      'idemployee': idemployee,
      'updated_at': updatedAt,
      // 'avatar2': avatar2.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userNum: map['user_num'] != null ? map['user_num'].toInt() : 0,
      globalID: map['global_id'] as String,
      userID2: map['user_id2'] as String,
      username: map['username'] as String,
      rememberToken: map['remember_token'] as String,
      verifiedAt: map['verified_at'] as String,
      lastActive: map['last_active'] as String,
      name1: map['name1'] as String,
      name2: map['name2'] as String,
      name3: map['name3'] as String,
      regNum: map['reg_num'] as String,
      plant: map['plant'] as String,
      division: map['division'] as String,
      dept: map['dept'] as String,
      section: map['section'] as String,
      position: map['position'] as String,
      userLevel: map['user_level'] as String,
      location: map['location'] as String,
      costCTR: map['cost_ctr'] as String,
      phone: map['phone'] as String,
      fax: map['fax'] as String,
      email: map['email'] as String,
      website: map['web_site'] as String,
      note1: map['note1'] as String,
      note2: map['note2'] as String,
      deployServer: map['deploy_server'] as String,
      activeFlag: map['active_flag'] as String,
      createdDate: map['created_date'] as String,
      dtModified: map['dt_modified'] as String,
      createdUser: map['created_user'] as String,
      userID: map['user_id'] as String,
      deptID: map['dept_id'] as String,
      waGroupID: map['wa_group_id'] as String,
      oldUserID: map['old_user_id'] ?? "",
      // avatar: Avatar.fromMap(map['avatar'] as Map<String,dynamic>),
      lastShiftID: map['last_shift_id'] as String,
      idemployee: map['idemployee'] as String,
      updatedAt: map['updated_at'] ?? "",
      // avatar2: Avatar2.fromMap(map['avatar2'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(user_num: $userNum, globalID: $globalID, userID2: $userID2, username: $username, rememberToken: $rememberToken, verifiedAt: $verifiedAt, lastActive: $lastActive, name1: $name1, name2: $name2, name3: $name3, regNum: $regNum, plant: $plant, division: $division, dept: $dept, section: $section, position: $position, userLevel: $userLevel, location: $location, costCTR: $costCTR, phone: $phone, fax: $fax, email: $email, website: $website, note1: $note1, note2: $note2, deployServer: $deployServer, activeFlag: $activeFlag, createdDate: $createdDate, dtModified: $dtModified, createdUser: $createdUser, userID: $userID, deptID: $deptID, waGroupID: $waGroupID, oldUserID: $oldUserID, lastShiftID: $lastShiftID, idemployee: $idemployee, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userNum == userNum &&
        other.globalID == globalID &&
        other.userID2 == userID2 &&
        other.username == username &&
        other.rememberToken == rememberToken &&
        other.verifiedAt == verifiedAt &&
        other.lastActive == lastActive &&
        other.name1 == name1 &&
        other.name2 == name2 &&
        other.name3 == name3 &&
        other.regNum == regNum &&
        other.plant == plant &&
        other.division == division &&
        other.dept == dept &&
        other.section == section &&
        other.position == position &&
        other.userLevel == userLevel &&
        other.location == location &&
        other.costCTR == costCTR &&
        other.phone == phone &&
        other.fax == fax &&
        other.email == email &&
        other.website == website &&
        other.note1 == note1 &&
        other.note2 == note2 &&
        other.deployServer == deployServer &&
        other.activeFlag == activeFlag &&
        other.createdDate == createdDate &&
        other.dtModified == dtModified &&
        other.createdUser == createdUser &&
        other.userID == userID &&
        other.deptID == deptID &&
        other.waGroupID == waGroupID &&
        other.oldUserID == oldUserID &&
        // other.avatar == avatar &&
        other.lastShiftID == lastShiftID &&
        other.idemployee == idemployee &&
        other.updatedAt == updatedAt;
    // other.avatar2 == avatar2;
  }

  @override
  int get hashCode {
    return userNum.hashCode ^
        globalID.hashCode ^
        userID2.hashCode ^
        username.hashCode ^
        rememberToken.hashCode ^
        verifiedAt.hashCode ^
        lastActive.hashCode ^
        name1.hashCode ^
        name2.hashCode ^
        name3.hashCode ^
        regNum.hashCode ^
        plant.hashCode ^
        division.hashCode ^
        dept.hashCode ^
        section.hashCode ^
        position.hashCode ^
        userLevel.hashCode ^
        location.hashCode ^
        costCTR.hashCode ^
        phone.hashCode ^
        fax.hashCode ^
        email.hashCode ^
        website.hashCode ^
        note1.hashCode ^
        note2.hashCode ^
        deployServer.hashCode ^
        activeFlag.hashCode ^
        createdDate.hashCode ^
        dtModified.hashCode ^
        createdUser.hashCode ^
        userID.hashCode ^
        deptID.hashCode ^
        waGroupID.hashCode ^
        oldUserID.hashCode ^
        // avatar.hashCode ^
        lastShiftID.hashCode ^
        idemployee.hashCode ^
        updatedAt.hashCode;
    // avatar2.hashCode;
  }
}
