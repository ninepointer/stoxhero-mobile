class UserMyCoursesResponse {
  String? status;
  String? message;
  List<UserMyCoursesData>? data;

  UserMyCoursesResponse({this.status, this.message, this.data});

  UserMyCoursesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserMyCoursesData>[];
      json['data'].forEach((v) {
        data!.add(new UserMyCoursesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserMyCoursesData {
  String? sId;
  String? courseName;
  int? maxEnrolments;
  int? coursePrice;
  int? discountedPrice;
  String? courseImage;
  int? userEnrolled;
  List<UserCoursesTopics>? topics;
  num? coursePrgress;
  List<String>? instructorName;
  int? rating;

  UserMyCoursesData(
      {this.sId,
      this.courseName,
      this.maxEnrolments,
      this.coursePrice,
      this.discountedPrice,
      this.courseImage,
      this.userEnrolled,
      this.topics,
      this.coursePrgress,
      this.instructorName,
      this.rating});

  UserMyCoursesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['courseName'];
    maxEnrolments = json['maxEnrolments'];
    coursePrice = json['coursePrice'];
    discountedPrice = json['discountedPrice'];
    courseImage = json['courseImage'];
    userEnrolled = json['userEnrolled'];
    if (json['topics'] != null) {
      topics = <UserCoursesTopics>[];
      json['topics'].forEach((v) {
        topics!.add(new UserCoursesTopics.fromJson(v));
      });
    }
    coursePrgress = json['coursePrgress'];
    instructorName = json['instructorName'].cast<String>();
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['maxEnrolments'] = this.maxEnrolments;
    data['coursePrice'] = this.coursePrice;
    data['discountedPrice'] = this.discountedPrice;
    data['courseImage'] = this.courseImage;
    data['userEnrolled'] = this.userEnrolled;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    data['coursePrgress'] = this.coursePrgress;
    data['instructorName'] = this.instructorName;
    data['rating'] = this.rating;
    return data;
  }
}

class UserCoursesTopics {
  int? order;
  String? topic;
  List<UserCoursesSubtopics>? subtopics;
  String? sId;

  UserCoursesTopics({this.order, this.topic, this.subtopics, this.sId});

  UserCoursesTopics.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    if (json['subtopics'] != null) {
      subtopics = <UserCoursesSubtopics>[];
      json['subtopics'].forEach((v) {
        subtopics!.add(new UserCoursesSubtopics.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['topic'] = this.topic;
    if (this.subtopics != null) {
      data['subtopics'] = this.subtopics!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class UserCoursesSubtopics {
  int? order;
  String? topic;
  String? videoUrl;
  String? videoKey;
  String? sId;

  UserCoursesSubtopics({this.order, this.topic, this.sId});

  UserCoursesSubtopics.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    videoUrl = json['videoUrl'];
    videoKey = json['videoKey'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['topic'] = this.topic;
    data['videoUrl'] = this.videoUrl;
    data['videoKey'] = this.videoKey;
    data['_id'] = this.sId;
    return data;
  }
}
