class CareerFormRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? collegeName;
  String? linkedInProfileLink;
  String? source;
  String? career;
  String? dob;
  String? priorTradingExperience;
  String? campaignCode;

  CareerFormRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.collegeName,
      this.linkedInProfileLink,
      this.source,
      this.career,
      this.dob,
      this.priorTradingExperience,
      this.campaignCode});

  CareerFormRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    collegeName = json['collegeName'];
    linkedInProfileLink = json['linkedInProfileLink'];
    source = json['source'];
    career = json['career'];
    dob = json['dob'];
    priorTradingExperience = json['priorTradingExperience'];
    campaignCode = json['campaignCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['collegeName'] = this.collegeName;
    data['linkedInProfileLink'] = this.linkedInProfileLink;
    data['source'] = this.source;
    data['career'] = this.career;
    data['dob'] = this.dob;
    data['priorTradingExperience'] = this.priorTradingExperience;
    data['campaignCode'] = this.campaignCode;
    return data;
  }
}
