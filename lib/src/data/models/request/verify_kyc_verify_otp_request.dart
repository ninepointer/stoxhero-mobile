class VarifyKYCVerifyOtpRequest {
  String? clintId;
  num? otp;
  String? panNumber;
  String? bankAccountNumber;
  String? ifsc;

  VarifyKYCVerifyOtpRequest(
      {this.clintId,
      this.otp,
      this.panNumber,
      this.bankAccountNumber,
      this.ifsc});

  VarifyKYCVerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    clintId = json['client_id'];
    otp = json['otp'];
    panNumber = json['panNumber'];
    bankAccountNumber = json['bankAccountNumber'];
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_id'] = this.clintId;
    data['otp'] = this.otp;
    data['panNumber'] = this.panNumber;
    data['bankAccountNumber'] = this.bankAccountNumber;
    data['ifsc'] = this.ifsc;

    return data;
  }
}
