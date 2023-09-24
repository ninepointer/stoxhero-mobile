class LoginDetailsResponse {
  UserImageDetails? aadhaarCardFrontImage;
  UserImageDetails? aadhaarCardBackImage;
  UserImageDetails? panCardFrontImage;
  UserImageDetails? passportPhoto;
  UserImageDetails? addressProofDocument;
  String? profilePhoto;
  String? sId;
  String? kYCStatus;
  int? iV;
  String? address;
  String? city;
  String? cohort;
  String? country;
  String? createdBy;
  String? degree;
  String? designation;
  String? dob;
  String? email;
  String? employeeid;
  String? firstName;
  num? fund;
  String? gender;
  String? joiningDate;
  String? lastModified;
  String? lastName;
  String? lastOccupation;
  String? location;
  String? pincode;
  String? mobile;
  String? myReferralCode;
  String? name;
  String? password;
  String? resetPasswordOTP;
  String? state;
  String? status;
  String? tradingExp;
  String? uId;
  String? whatsAppNumber;
  String? aadhaarNumber;
  String? panNumber;
  String? drivingLicenseNumber;
  String? passportNumber;
  String? accountNumber;
  String? bankName;
  String? googlePayNumber;
  String? ifscCode;
  String? nameAsPerBankAccount;
  String? payTMNumber;
  String? phonePeNumber;
  String? upiId;
  String? mobileOtp;
  bool? isAlgoTrader;
  List<String>? watchlistInstruments;
  List<String>? contests;
  List<ProfilePortfolio>? portfolio;
  List<Referrals>? referrals;
  List<Subscription>? subscription;

  LoginDetailsResponse({
    this.aadhaarCardFrontImage,
    this.aadhaarCardBackImage,
    this.panCardFrontImage,
    this.passportPhoto,
    this.addressProofDocument,
    this.profilePhoto,
    this.sId,
    this.kYCStatus,
    this.iV,
    this.address,
    this.city,
    this.cohort,
    this.country,
    this.createdBy,
    this.degree,
    this.designation,
    this.dob,
    this.email,
    this.employeeid,
    this.firstName,
    this.fund,
    this.gender,
    this.joiningDate,
    this.lastModified,
    this.lastName,
    this.lastOccupation,
    this.location,
    this.pincode,
    this.mobile,
    this.myReferralCode,
    this.name,
    this.password,
    this.resetPasswordOTP,
    this.state,
    this.status,
    this.tradingExp,
    this.uId,
    this.whatsAppNumber,
    this.aadhaarNumber,
    this.panNumber,
    this.drivingLicenseNumber,
    this.passportNumber,
    this.accountNumber,
    this.bankName,
    this.googlePayNumber,
    this.ifscCode,
    this.nameAsPerBankAccount,
    this.payTMNumber,
    this.phonePeNumber,
    this.upiId,
    this.mobileOtp,
    this.isAlgoTrader,
    this.watchlistInstruments,
    this.contests,
    this.portfolio,
    this.referrals,
    this.subscription,
  });

  LoginDetailsResponse.fromJson(Map<String, dynamic> json) {
    aadhaarCardFrontImage = json['aadhaarCardFrontImage'] != null
        ? new UserImageDetails.fromJson(
            json['aadhaarCardFrontImage'],
          )
        : null;
    aadhaarCardBackImage = json['aadhaarCardBackImage'] != null
        ? new UserImageDetails.fromJson(
            json['aadhaarCardBackImage'],
          )
        : null;
    panCardFrontImage = json['panCardFrontImage'] != null
        ? new UserImageDetails.fromJson(
            json['panCardFrontImage'],
          )
        : null;
    passportPhoto = json['passportPhoto'] != null
        ? new UserImageDetails.fromJson(
            json['passportPhoto'],
          )
        : null;
    addressProofDocument = json['addressProofDocument'] != null
        ? new UserImageDetails.fromJson(
            json['addressProofDocument'],
          )
        : null;
    profilePhoto = json['profilePhoto'].toString();
    sId = json['_id'];
    kYCStatus = json['KYCStatus'];
    iV = json['__v'];
    address = json['address'];
    city = json['city'];
    cohort = json['cohort'];
    country = json['country'];
    createdBy = json['createdBy'];
    degree = json['degree'];
    designation = json['designation'];
    dob = json['dob'];
    email = json['email'];
    employeeid = json['employeeid'];
    firstName = json['first_name'];
    fund = json['fund'];
    gender = json['gender'];
    joiningDate = json['joining_date'];
    lastModified = json['lastModified'];
    lastName = json['last_name'];
    lastOccupation = json['last_occupation'];
    location = json['location'];
    pincode = json['pincode'];
    mobile = json['mobile'];
    myReferralCode = json['myReferralCode'];
    name = json['name'];
    password = json['password'];
    resetPasswordOTP = json['resetPasswordOTP'];
    state = json['state'];
    status = json['status'];
    tradingExp = json['trading_exp'];
    uId = json['uId'];
    whatsAppNumber = json['whatsApp_number'];
    aadhaarNumber = json['aadhaarNumber'];
    panNumber = json['panNumber'];
    drivingLicenseNumber = json['drivingLicenseNumber'];
    passportNumber = json['passportNumber'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    googlePayNumber = json['googlePay_number'];
    ifscCode = json['ifscCode'];
    nameAsPerBankAccount = json['nameAsPerBankAccount'];
    payTMNumber = json['payTM_number'];
    phonePeNumber = json['phonePe_number'];
    upiId = json['upiId'];
    mobileOtp = json['mobile_otp'];
    isAlgoTrader = json['isAlgoTrader'];
    watchlistInstruments = json['watchlistInstruments'].cast<String>();
    contests = json['contests'].cast<String>();
    if (json['portfolio'] != null) {
      portfolio = <ProfilePortfolio>[];
      json['portfolio'].forEach((v) {
        portfolio!.add(new ProfilePortfolio.fromJson(v));
      });
    }
    if (json['referrals'] != null) {
      referrals = <Referrals>[];
      json['referrals'].forEach((v) {
        referrals!.add(new Referrals.fromJson(v));
      });
    }
    if (json['subscription'] != null) {
      subscription = <Subscription>[];
      json['subscription'].forEach((v) {
        subscription!.add(new Subscription.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aadhaarCardFrontImage != null) {
      data['aadhaarCardFrontImage'] = this.aadhaarCardFrontImage!.toJson();
    }
    if (this.aadhaarCardBackImage != null) {
      data['aadhaarCardBackImage'] = this.aadhaarCardBackImage!.toJson();
    }
    if (this.panCardFrontImage != null) {
      data['panCardFrontImage'] = this.panCardFrontImage!.toJson();
    }
    if (this.passportPhoto != null) {
      data['passportPhoto'] = this.passportPhoto!.toJson();
    }
    if (this.addressProofDocument != null) {
      data['addressProofDocument'] = this.addressProofDocument!.toJson();
    }
    if (this.profilePhoto != null) {
      data['profilePhoto'] = this.profilePhoto.toString();
    }
    data['_id'] = this.sId;
    data['KYCStatus'] = this.kYCStatus;
    data['__v'] = this.iV;
    data['address'] = this.address;
    data['city'] = this.city;
    data['cohort'] = this.cohort;
    data['country'] = this.country;
    data['createdBy'] = this.createdBy;
    data['degree'] = this.degree;
    data['designation'] = this.designation;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['employeeid'] = this.employeeid;
    data['first_name'] = this.firstName;
    data['fund'] = this.fund;
    data['gender'] = this.gender;
    data['joining_date'] = this.joiningDate;
    data['lastModified'] = this.lastModified;
    data['last_name'] = this.lastName;
    data['last_occupation'] = this.lastOccupation;
    data['location'] = this.location;
    data['pincode'] = this.pincode;
    data['mobile'] = this.mobile;
    data['myReferralCode'] = this.myReferralCode;
    data['name'] = this.name;
    data['password'] = this.password;
    data['resetPasswordOTP'] = this.resetPasswordOTP;
    data['state'] = this.state;
    data['status'] = this.status;
    data['trading_exp'] = this.tradingExp;
    data['uId'] = this.uId;
    data['whatsApp_number'] = this.whatsAppNumber;
    data['aadhaarNumber'] = this.aadhaarNumber;
    data['panNumber'] = this.panNumber;
    data['drivingLicenseNumber'] = this.drivingLicenseNumber;
    data['passportNumber'] = this.passportNumber;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['googlePay_number'] = this.googlePayNumber;
    data['ifscCode'] = this.ifscCode;
    data['nameAsPerBankAccount'] = this.nameAsPerBankAccount;
    data['payTM_number'] = this.payTMNumber;
    data['phonePe_number'] = this.phonePeNumber;
    data['upiId'] = this.upiId;
    data['mobile_otp'] = this.mobileOtp;
    data['isAlgoTrader'] = this.isAlgoTrader;
    data['watchlistInstruments'] = this.watchlistInstruments;
    data['contests'] = this.contests;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.map((v) => v.toJson()).toList();
    }
    if (this.referrals != null) {
      data['referrals'] = this.referrals!.map((v) => v.toJson()).toList();
    }
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  LoginDetailsResponse copyWith({
    UserImageDetails? aadhaarCardFrontImage,
    UserImageDetails? aadhaarCardBackImage,
    UserImageDetails? panCardFrontImage,
    UserImageDetails? passportPhoto,
    UserImageDetails? addressProofDocument,
    String? profilePhoto,
    String? sId,
    String? kYCStatus,
    int? iV,
    String? address,
    String? city,
    String? cohort,
    String? country,
    String? createdBy,
    String? degree,
    String? designation,
    String? dob,
    String? email,
    String? employeeid,
    String? firstName,
    num? fund,
    String? gender,
    String? joiningDate,
    String? lastModified,
    String? lastName,
    String? lastOccupation,
    String? location,
    String? pincode,
    String? mobile,
    String? myReferralCode,
    String? name,
    String? password,
    String? resetPasswordOTP,
    String? state,
    String? status,
    String? tradingExp,
    String? uId,
    String? whatsAppNumber,
    String? aadhaarNumber,
    String? panNumber,
    String? drivingLicenseNumber,
    String? passportNumber,
    String? accountNumber,
    String? bankName,
    String? googlePayNumber,
    String? ifscCode,
    String? nameAsPerBankAccount,
    String? payTMNumber,
    String? phonePeNumber,
    String? upiId,
    String? mobileOtp,
    bool? isAlgoTrader,
    List<String>? watchlistInstruments,
    List<String>? contests,
    List<ProfilePortfolio>? portfolio,
    List<Referrals>? referrals,
  }) {
    return LoginDetailsResponse(
      aadhaarCardFrontImage: aadhaarCardFrontImage ?? this.aadhaarCardFrontImage,
      aadhaarCardBackImage: aadhaarCardBackImage ?? this.aadhaarCardBackImage,
      panCardFrontImage: panCardFrontImage ?? this.panCardFrontImage,
      passportPhoto: passportPhoto ?? this.passportPhoto,
      addressProofDocument: addressProofDocument ?? this.addressProofDocument,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      sId: sId ?? this.sId,
      kYCStatus: kYCStatus ?? this.kYCStatus,
      iV: iV ?? this.iV,
      address: address ?? this.address,
      city: city ?? this.city,
      cohort: cohort ?? this.cohort,
      country: country ?? this.country,
      createdBy: createdBy ?? this.createdBy,
      degree: degree ?? this.degree,
      designation: designation ?? this.designation,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      employeeid: employeeid ?? this.employeeid,
      firstName: firstName ?? this.firstName,
      fund: fund ?? this.fund,
      gender: gender ?? this.gender,
      joiningDate: joiningDate ?? this.joiningDate,
      lastModified: lastModified ?? this.lastModified,
      lastName: lastName ?? this.lastName,
      lastOccupation: lastOccupation ?? this.lastOccupation,
      location: location ?? this.location,
      pincode: pincode ?? this.pincode,
      mobile: mobile ?? this.mobile,
      myReferralCode: myReferralCode ?? this.myReferralCode,
      name: name ?? this.name,
      password: password ?? this.password,
      resetPasswordOTP: resetPasswordOTP ?? this.resetPasswordOTP,
      state: state ?? this.state,
      status: status ?? this.status,
      tradingExp: tradingExp ?? this.tradingExp,
      uId: uId ?? this.uId,
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      panNumber: panNumber ?? this.panNumber,
      drivingLicenseNumber: drivingLicenseNumber ?? this.drivingLicenseNumber,
      passportNumber: passportNumber ?? this.passportNumber,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      googlePayNumber: googlePayNumber ?? this.googlePayNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      nameAsPerBankAccount: nameAsPerBankAccount ?? this.nameAsPerBankAccount,
      payTMNumber: payTMNumber ?? this.payTMNumber,
      phonePeNumber: phonePeNumber ?? this.phonePeNumber,
      upiId: upiId ?? this.upiId,
      mobileOtp: mobileOtp ?? this.mobileOtp,
      isAlgoTrader: isAlgoTrader ?? this.isAlgoTrader,
      watchlistInstruments: watchlistInstruments ?? this.watchlistInstruments,
      contests: contests ?? this.contests,
      portfolio: portfolio ?? this.portfolio,
      referrals: referrals ?? this.referrals,
    );
  }
}

class UserImageDetails {
  String? url;
  String? name;

  UserImageDetails({
    this.url,
    this.name,
  });

  UserImageDetails.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class ProfilePortfolio {
  String? sId;
  String? activationDate;
  PortfolioId? portfolioId;

  ProfilePortfolio({this.sId, this.activationDate, this.portfolioId});

  ProfilePortfolio.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    activationDate = json['activationDate'];
    portfolioId =
        json['portfolioId'] != null ? new PortfolioId.fromJson(json['portfolioId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['activationDate'] = this.activationDate;
    if (this.portfolioId != null) {
      data['portfolioId'] = this.portfolioId!.toJson();
    }
    return data;
  }
}

class PortfolioId {
  String? sId;
  String? portfolioAccount;
  String? portfolioName;
  String? portfolioType;
  int? portfolioValue;

  PortfolioId({
    this.sId,
    this.portfolioAccount,
    this.portfolioName,
    this.portfolioType,
    this.portfolioValue,
  });

  PortfolioId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    portfolioAccount = json['portfolioAccount'];
    portfolioName = json['portfolioName'];
    portfolioType = json['portfolioType'];
    portfolioValue = json['portfolioValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['portfolioAccount'] = this.portfolioAccount;
    data['portfolioName'] = this.portfolioName;
    data['portfolioType'] = this.portfolioType;
    data['portfolioValue'] = this.portfolioValue;
    return data;
  }
}

class Referrals {
  String? referredUserId;
  num? referralEarning;
  String? referralProgram;
  String? referralCurrency;
  String? sId;

  Referrals({
    this.referredUserId,
    this.referralEarning,
    this.referralProgram,
    this.referralCurrency,
    this.sId,
  });

  Referrals.fromJson(Map<String, dynamic> json) {
    referredUserId = json['referredUserId'];
    referralEarning = json['referralEarning'];
    referralProgram = json['referralProgram'];
    referralCurrency = json['referralCurrency'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referredUserId'] = this.referredUserId;
    data['referralEarning'] = this.referralEarning;
    data['referralProgram'] = this.referralProgram;
    data['referralCurrency'] = this.referralCurrency;
    data['_id'] = this.sId;
    return data;
  }
}

class Subscription {
  SubscriptionId? subscriptionId;
  String? subscribedOn;
  String? status;
  String? sId;

  Subscription({
    this.subscriptionId,
    this.subscribedOn,
    this.status,
    this.sId,
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    subscriptionId =
        json['subscriptionId'] != null ? new SubscriptionId.fromJson(json['subscriptionId']) : null;
    subscribedOn = json['subscribedOn'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscriptionId != null) {
      data['subscriptionId'] = this.subscriptionId!.toJson();
    }
    data['subscribedOn'] = this.subscribedOn;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class SubscriptionId {
  String? sId;
  PortfolioDetails? portfolio;

  SubscriptionId({
    this.sId,
    this.portfolio,
  });

  SubscriptionId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    portfolio = json['portfolio'] != null ? new PortfolioDetails.fromJson(json['portfolio']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    return data;
  }
}

class PortfolioDetails {
  String? sId;
  String? portfolioAccount;
  String? portfolioName;
  String? portfolioType;
  int? portfolioValue;

  PortfolioDetails({
    this.sId,
    this.portfolioAccount,
    this.portfolioName,
    this.portfolioType,
    this.portfolioValue,
  });

  PortfolioDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    portfolioAccount = json['portfolioAccount'];
    portfolioName = json['portfolioName'];
    portfolioType = json['portfolioType'];
    portfolioValue = json['portfolioValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['portfolioAccount'] = this.portfolioAccount;
    data['portfolioName'] = this.portfolioName;
    data['portfolioType'] = this.portfolioType;
    data['portfolioValue'] = this.portfolioValue;
    return data;
  }
}
