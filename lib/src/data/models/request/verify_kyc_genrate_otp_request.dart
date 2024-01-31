class VarifyKYCGenrateOtpRequest {
  String? aadhaarNumber;

  VarifyKYCGenrateOtpRequest({
    this.aadhaarNumber,
  });

  VarifyKYCGenrateOtpRequest.fromJson(Map<String, dynamic> json) {
    aadhaarNumber = json['aadhaarNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aadhaarNumber'] = this.aadhaarNumber;
    return data;
  }
}
