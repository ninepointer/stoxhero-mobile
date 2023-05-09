class SignupRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;

  SignupRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
  });

  SignupRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    return data;
  }
}
