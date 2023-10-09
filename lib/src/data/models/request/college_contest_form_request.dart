class CollegeContestFormRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? collegeName;
  String? source;
  String? contest;
  String? dob;

  CollegeContestFormRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.collegeName,
    this.source,
    this.contest,
    this.dob,
  });

  CollegeContestFormRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    collegeName = json['collegeName'];
    source = json['source'];
    contest = json['contest'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['collegeName'] = this.collegeName;
    data['source'] = this.source;
    data['contest'] = this.contest;
    data['dob'] = this.dob;
    return data;
  }
}
