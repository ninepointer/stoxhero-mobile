class VerifyKYCGenrateOTPResponse {
  String? status;
  VerifyKYCGenrateOTPData? data;

  VerifyKYCGenrateOTPResponse({this.status, this.data});

  VerifyKYCGenrateOTPResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new VerifyKYCGenrateOTPData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class VerifyKYCGenrateOTPData {
  String? clientId;
  bool? otpSent;
  bool? ifNumber;
  bool? validAadhaar;
  String? status;

  VerifyKYCGenrateOTPData(
      {this.clientId,
      this.otpSent,
      this.ifNumber,
      this.validAadhaar,
      this.status});

  VerifyKYCGenrateOTPData.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    otpSent = json['otp_sent'];
    ifNumber = json['if_number'];
    validAadhaar = json['valid_aadhaar'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clientId;
    data['otp_sent'] = this.otpSent;
    data['if_number'] = this.ifNumber;
    data['valid_aadhaar'] = this.validAadhaar;
    data['status'] = this.status;
    return data;
  }
}
