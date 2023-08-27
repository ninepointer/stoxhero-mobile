import '../../data.dart';

class MyReferralsResponse {
  List<MyReferralData>? data;
  int? count;

  MyReferralsResponse({this.data, this.count});

  MyReferralsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyReferralData>[];
      json['data'].forEach((v) {
        data!.add(new MyReferralData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class MyReferralData {
  String? sId;
  String? status;
  String? uId;
  String? name;
  String? firstName;
  String? lastName;
  String? designation;
  String? email;
  String? mobile;
  String? joiningDate;
  String? role;
  String? creationProcess;
  String? employeeid;
  String? password;
  String? referralProgramme;
  String? kYCStatus;
  String? myReferralCode;
  String? referrerCode;
  String? referredBy;
  List<Referrals>? referrals;

  MyReferralData({
    this.sId,
    this.status,
    this.uId,
    this.name,
    this.firstName,
    this.lastName,
    this.designation,
    this.email,
    this.mobile,
    this.joiningDate,
    this.role,
    this.creationProcess,
    this.employeeid,
    this.password,
    this.referralProgramme,
    this.kYCStatus,
    this.myReferralCode,
    this.referrerCode,
    this.referredBy,
    this.referrals,
  });

  MyReferralData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    uId = json['uId'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    designation = json['designation'];
    email = json['email'];
    mobile = json['mobile'];
    joiningDate = json['joining_date'];
    role = json['role'];
    creationProcess = json['creationProcess'];
    employeeid = json['employeeid'];
    password = json['password'];
    referralProgramme = json['referralProgramme'];
    kYCStatus = json['KYCStatus'];
    myReferralCode = json['myReferralCode'];
    referrerCode = json['referrerCode'];
    referredBy = json['referredBy'];
    if (json['referrals'] != null) {
      referrals = <Referrals>[];
      json['referrals'].forEach((v) {
        referrals!.add(new Referrals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = this.sId;
    data['status'] = this.status;
    data['uId'] = this.uId;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['joining_date'] = this.joiningDate;
    data['role'] = this.role;
    data['creationProcess'] = this.creationProcess;
    data['employeeid'] = this.employeeid;
    data['password'] = this.password;
    data['referralProgramme'] = this.referralProgramme;
    data['KYCStatus'] = this.kYCStatus;
    data['myReferralCode'] = this.myReferralCode;
    data['referrerCode'] = this.referrerCode;
    data['referredBy'] = this.referredBy;
    if (this.referrals != null) {
      data['referrals'] = this.referrals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
