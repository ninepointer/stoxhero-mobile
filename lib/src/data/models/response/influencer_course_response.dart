class InfluencerCourseResponse {
  String? status;
  List<InfluencerCourseData>? data;
  int? count;

  InfluencerCourseResponse({this.status, this.data, this.count});

  InfluencerCourseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <InfluencerCourseData>[];
      json['data'].forEach((v) {
        data!.add(new InfluencerCourseData.fromJson(v));
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

class InfluencerCourseData {
  String? sId;
  String? courseName;
  String? courseStartTime;
  int? maxEnrolments;
  String? courseImage;
  int? userEnrolled;

  InfluencerCourseData(
      {this.sId,
      this.courseName,
      this.courseStartTime,
      this.maxEnrolments,
      this.courseImage,
      this.userEnrolled});

  InfluencerCourseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['courseName'];
    courseStartTime = json['courseStartTime'];
    maxEnrolments = json['maxEnrolments'];
    courseImage = json['courseImage'];
    userEnrolled = json['userEnrolled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['courseStartTime'] = this.courseStartTime;
    data['maxEnrolments'] = this.maxEnrolments;
    data['courseImage'] = this.courseImage;
    data['userEnrolled'] = this.userEnrolled;
    return data;
  }
}
