class NewUserCreateAccountResponse {
  String? status;
  CreateNewUserAccountData? data;
  String? message;
  String? token;

  NewUserCreateAccountResponse(
      {this.status, this.data, this.message, this.token});

  NewUserCreateAccountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new CreateNewUserAccountData.fromJson(json['data'])
        : null;
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}

class CreateNewUserAccountData {
  String? sId;
  String? status;
  String? name;
  String? firstName;
  String? lastName;
  String? designation;
  String? email;
  String? mobile;
  String? joiningDate;
  UserRole? role;
  String? employeeid;
  // List<Null>? watchlistInstruments;
  String? kYCStatus;
  String? myReferralCode;
  // List<Null>? contests;
  List<UserPortfolio>? portfolio;
  bool? isAlgoTrader;
  // List<Null>? internshipBatch;
  // List<Null>? referrals;
  // List<Null>? subscription;

  CreateNewUserAccountData({
    this.sId,
    this.status,
    this.name,
    this.firstName,
    this.lastName,
    this.designation,
    this.email,
    this.mobile,
    this.joiningDate,
    this.role,
    this.employeeid,
    // this.watchlistInstruments,
    this.kYCStatus,
    this.myReferralCode,
    // this.contests,
    this.portfolio,
    this.isAlgoTrader,
    // this.internshipBatch,
    // this.referrals,
    // this.subscription,
  });

  CreateNewUserAccountData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    designation = json['designation'];
    email = json['email'];
    mobile = json['mobile'];
    joiningDate = json['joining_date'];
    role = json['role'] != null ? new UserRole.fromJson(json['role']) : null;
    employeeid = json['employeeid'];
    // if (json['watchlistInstruments'] != null) {
    //   watchlistInstruments = <Null>[];
    // json['watchlistInstruments'].forEach((v) {
    //   watchlistInstruments!.add(new Null.fromJson(v));
    // });
    // }
    kYCStatus = json['KYCStatus'];
    myReferralCode = json['myReferralCode'];
    // if (json['contests'] != null) {
    //   contests = <Null>[];
    //   json['contests'].forEach((v) {
    //     contests!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['portfolio'] != null) {
      portfolio = <UserPortfolio>[];
      json['portfolio'].forEach((v) {
        portfolio!.add(new UserPortfolio.fromJson(v));
      });
    }
    isAlgoTrader = json['isAlgoTrader'];
    // if (json['internshipBatch'] != null) {
    //   internshipBatch = <Null>[];
    //   json['internshipBatch'].forEach((v) {
    //     internshipBatch!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['referrals'] != null) {
    //   referrals = <Null>[];
    //   json['referrals'].forEach((v) {
    //     referrals!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['subscription'] != null) {
    //   subscription = <Null>[];
    //   json['subscription'].forEach((v) {
    //     subscription!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['joining_date'] = this.joiningDate;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    data['employeeid'] = this.employeeid;
    // if (this.watchlistInstruments != null) {
    //   data['watchlistInstruments'] =
    //       this.watchlistInstruments!.map((v) => v.toJson()).toList();
    // }
    data['KYCStatus'] = this.kYCStatus;
    data['myReferralCode'] = this.myReferralCode;
    // if (this.contests != null) {
    //   data['contests'] = this.contests!.map((v) => v.toJson()).toList();
    // }
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.map((v) => v.toJson()).toList();
    }
    data['isAlgoTrader'] = this.isAlgoTrader;
    // if (this.internshipBatch != null) {
    //   data['internshipBatch'] =
    //       this.internshipBatch!.map((v) => v.toJson()).toList();
    // }
    // if (this.referrals != null) {
    //   data['referrals'] = this.referrals!.map((v) => v.toJson()).toList();
    // }
    // if (this.subscription != null) {
    //   data['subscription'] = this.subscription!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class UserRole {
  String? sId;
  String? roleName;

  UserRole({this.sId, this.roleName});

  UserRole.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    roleName = json['roleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['roleName'] = this.roleName;
    return data;
  }
}

class UserPortfolio {
  String? activationDate;
  UserPortfolioId? portfolioId;
  String? sId;

  UserPortfolio({this.activationDate, this.portfolioId, this.sId});

  UserPortfolio.fromJson(Map<String, dynamic> json) {
    activationDate = json['activationDate'];
    portfolioId = json['portfolioId'] != null
        ? new UserPortfolioId.fromJson(json['portfolioId'])
        : null;
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activationDate'] = this.activationDate;
    if (this.portfolioId != null) {
      data['portfolioId'] = this.portfolioId!.toJson();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class UserPortfolioId {
  String? sId;
  String? portfolioName;
  int? portfolioValue;
  String? portfolioAccount;
  String? portfolioType;

  UserPortfolioId(
      {this.sId,
      this.portfolioName,
      this.portfolioValue,
      this.portfolioAccount,
      this.portfolioType});

  UserPortfolioId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    portfolioName = json['portfolioName'];
    portfolioValue = json['portfolioValue'];
    portfolioAccount = json['portfolioAccount'];
    portfolioType = json['portfolioType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['portfolioName'] = this.portfolioName;
    data['portfolioValue'] = this.portfolioValue;
    data['portfolioAccount'] = this.portfolioAccount;
    data['portfolioType'] = this.portfolioType;
    return data;
  }
}
