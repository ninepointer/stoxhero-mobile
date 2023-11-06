// class CareerFormRequest {
//   String? dob;
//   String? college;
//   String? collegeName;
//   String? linkedInProfileLink;
//   String? priorTradingExperience;
//   String? source;
//   String? career;
//   String? campaignCode;

//   CareerFormRequest({
//     this.dob,
//     this.college,
//     this.collegeName,
//     this.linkedInProfileLink,
//     this.priorTradingExperience,
//     this.source,
//     this.career,
//     this.campaignCode,
//   });

//   CareerFormRequest.fromJson(Map<String, dynamic> json) {
//     dob = json['dob'];
//     college = json['college'];
//     collegeName = json['collegeName'];
//     linkedInProfileLink = json['linkedInProfileLink'];
//     priorTradingExperience = json['priorTradingExperience'];
//     source = json['source'];
//     career = json['career'];
//     campaignCode = json['campaignCode'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['dob'] = this.dob;
//     data['college'] = this.college;
//     data['collegeName'] = this.collegeName;
//     data['linkedInProfileLink'] = this.linkedInProfileLink;
//     data['priorTradingExperience'] = this.priorTradingExperience;
//     data['source'] = this.source;
//     data['career'] = this.career;
//     data['campaignCode'] = this.campaignCode;
//     return data;
//   }
// }

class CareerFormRequest {
  String? college;
  String? collegeName;
  String? course;
  String? passingoutyear;
  String? linkedInProfileLink;
  String? source;
  String? career;
  String? dob;
  String? gender;
  String? priorTradingExperience;
  String? campaignCode;

  CareerFormRequest({
    this.college,
    this.collegeName,
    this.course,
    this.passingoutyear,
    this.linkedInProfileLink,
    this.source,
    this.career,
    this.dob,
    this.gender,
    this.priorTradingExperience,
    this.campaignCode,
  });

  CareerFormRequest.fromJson(Map<String, dynamic> json) {
    college = json['college'];
    collegeName = json['collegeName'];
    course = json['course'];
    passingoutyear = json['passingoutyear'];
    linkedInProfileLink = json['linkedInProfileLink'];
    source = json['source'];
    career = json['career'];
    dob = json['dob'];
    gender = json['gender'];
    priorTradingExperience = json['priorTradingExperience'];
    campaignCode = json['campaignCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['college'] = this.college;
    data['collegeName'] = this.collegeName;
    data['course'] = this.course;
    data['passingoutyear'] = this.passingoutyear;
    data['linkedInProfileLink'] = this.linkedInProfileLink;
    data['source'] = this.source;
    data['career'] = this.career;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['priorTradingExperience'] = this.priorTradingExperience;
    data['campaignCode'] = this.campaignCode;
    return data;
  }
}
