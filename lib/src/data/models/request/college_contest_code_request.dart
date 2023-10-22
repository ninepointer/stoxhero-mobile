class CollegeContestCodeRequest {
  String? collegeCode;

  CollegeContestCodeRequest({this.collegeCode});

  CollegeContestCodeRequest.fromJson(Map<String, dynamic> json) {
    collegeCode = json['collegeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collegeCode'] = this.collegeCode;
    return data;
  }
}
