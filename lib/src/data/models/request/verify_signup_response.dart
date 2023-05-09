class VerifySignupRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? mobileOtp;
  String? referrerCode;

  VerifySignupRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.mobileOtp,
    this.referrerCode,
  });

  VerifySignupRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    mobileOtp = json['mobile_otp'];
    referrerCode = json['referrerCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['mobile_otp'] = this.mobileOtp;
    data['referrerCode'] = this.referrerCode;
    return data;
  }
}
