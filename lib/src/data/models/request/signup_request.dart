class SignupRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? dob;
  String? gender;
  String? tradingExp;
  String? city;
  String? state;
  String? country;
  bool? employeed;
  String? purposeOfJoining;
  bool? termsAndConditions;
  String? tradingAccount;
  String? referrerCode;
  String? campaignCode;
  String? pincode;

  SignupRequest({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.mobile = "",
    this.dob = "",
    this.gender = "",
    this.tradingExp = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.employeed = false,
    this.purposeOfJoining = "",
    this.termsAndConditions = false,
    this.tradingAccount = "",
    this.referrerCode = "",
    this.campaignCode = "",
    this.pincode = "",
  });

  SignupRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    tradingExp = json['trading_exp'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    employeed = json['employeed'];
    purposeOfJoining = json['purpose_of_joining'];
    termsAndConditions = json['terms_and_conditions'];
    tradingAccount = json['trading_account'];
    referrerCode = json['referrerCode'];
    campaignCode = json['campaignCode'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['trading_exp'] = this.tradingExp;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['employeed'] = this.employeed;
    data['purpose_of_joining'] = this.purposeOfJoining;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['trading_account'] = this.tradingAccount;
    data['referrerCode'] = this.referrerCode;
    data['campaignCode'] = this.campaignCode;
    data['pincode'] = this.pincode;
    return data;
  }
}
