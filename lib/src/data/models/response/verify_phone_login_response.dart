class VerifyPhoneLoginResponse {
  String? status;
  String? message;
  String? token;
  bool? isLogin;

  VerifyPhoneLoginResponse({
    this.status,
    this.message,
    this.token,
    this.isLogin,
  });

  VerifyPhoneLoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    isLogin = json['login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    data['login'] = this.isLogin;
    return data;
  }
}
