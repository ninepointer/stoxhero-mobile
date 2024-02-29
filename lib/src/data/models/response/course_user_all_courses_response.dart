class UserAllCoursesResponse {
  String? status;
  List<UserAllCoursesData>? data;
  int? count;

  UserAllCoursesResponse({this.status, this.data, this.count});

  UserAllCoursesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UserAllCoursesData>[];
      json['data'].forEach((v) {
        data!.add(new UserAllCoursesData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class UserAllCoursesData {
  String? sId;
  String? courseName;
  String? courseStartTime;
  int? maxEnrolments;
  int? coursePrice;
  int? discountedPrice;
  String? courseImage;
  int? userEnrolled;
  List<String>? instructorName;

  UserAllCoursesData(
      {this.sId,
      this.courseName,
      this.courseStartTime,
      this.maxEnrolments,
      this.coursePrice,
      this.discountedPrice,
      this.courseImage,
      this.userEnrolled,
      this.instructorName});

  UserAllCoursesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['courseName'];
    courseStartTime = json['courseStartTime'];
    maxEnrolments = json['maxEnrolments'];
    coursePrice = json['coursePrice'];
    discountedPrice = json['discountedPrice'];
    courseImage = json['courseImage'];
    userEnrolled = json['userEnrolled'];
    instructorName = json['instructorName'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['courseStartTime'] = this.courseStartTime;
    data['maxEnrolments'] = this.maxEnrolments;
    data['coursePrice'] = this.coursePrice;
    data['discountedPrice'] = this.discountedPrice;
    data['courseImage'] = this.courseImage;
    data['userEnrolled'] = this.userEnrolled;
    data['instructorName'] = this.instructorName;
    return data;
  }
}
