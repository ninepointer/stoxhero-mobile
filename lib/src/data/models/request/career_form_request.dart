class CareerFormRequest {
  String? dob;
  String? collegeName;
  String? linkedInProfileLink;
  String? priorTradingExperience;
  String? source;
  String? career;
  String? campaignCode;

  CareerFormRequest(
      {this.dob,
      this.collegeName,
      this.linkedInProfileLink,
      this.priorTradingExperience,
      this.source,
      this.career,
      this.campaignCode});

  CareerFormRequest.fromJson(Map<String, dynamic> json) {
    dob = json['dob'];
    collegeName = json['collegeName'];
    linkedInProfileLink = json['linkedInProfileLink'];
    priorTradingExperience = json['priorTradingExperience'];
    source = json['source'];
    career = json['career'];
    campaignCode = json['campaignCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dob'] = this.dob;
    data['collegeName'] = this.collegeName;
    data['linkedInProfileLink'] = this.linkedInProfileLink;
    data['priorTradingExperience'] = this.priorTradingExperience;
    data['source'] = this.source;
    data['career'] = this.career;
    data['campaignCode'] = this.campaignCode;
    return data;
  }
}
