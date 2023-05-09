class VerifyPhoneLoginResponse {
  String? status;
  String? message;
  String? token;

  VerifyPhoneLoginResponse({
    this.status,
    this.message,
    this.token,
  });

  VerifyPhoneLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}
