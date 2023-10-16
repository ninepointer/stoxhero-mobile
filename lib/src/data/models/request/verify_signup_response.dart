class VerifySignupRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? mobileOtp;
  String? referrerCode;
  String? dob;

  VerifySignupRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.mobileOtp,
    this.referrerCode,
    this.dob,
  });

  VerifySignupRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    mobileOtp = json['mobile_otp'];
    referrerCode = json['referrerCode'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['mobile_otp'] = this.mobileOtp;
    data['referrerCode'] = this.referrerCode;
    data['dob'] = this.dob;
    return data;
  }
}
