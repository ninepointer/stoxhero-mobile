class VerifySigninRequest {
  String? mobile;
  String? mobileOtp;

  VerifySigninRequest({
    this.mobile,
    this.mobileOtp,
  });

  VerifySigninRequest.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    mobileOtp = json['mobile_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['mobile_otp'] = this.mobileOtp;
    return data;
  }
}
