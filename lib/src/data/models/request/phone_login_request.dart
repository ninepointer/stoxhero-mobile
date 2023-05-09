class PhoneLoginRequest {
  String? mobile;

  PhoneLoginRequest({
    this.mobile,
  });

  PhoneLoginRequest.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    return data;
  }
}
