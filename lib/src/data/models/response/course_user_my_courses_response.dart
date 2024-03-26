class UserMyCoursesResponse {
  String? status;
  String? message;
  List<UserMyCoursesData>? data;
  List<UserMyCoursesData>? workshop;
  UserMyCoursesResponse({
    this.status,
    this.message,
    this.workshop,
    this.data,
  });

  UserMyCoursesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['workshop'] != null) {
      workshop = <UserMyCoursesData>[];
      json['workshop'].forEach((v) {
        workshop!.add(new UserMyCoursesData.fromJson(v));
      });
    }
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
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserMyCoursesData {
  String? sId;
  String? courseName;
  String? slug;
  int? maxEnrolments;
  int? coursePrice;
  int? discountedPrice;
  String? courseImage;
  int? userEnrolled;
  List<UserCoursesTopics>? topics;
  num? coursePrgress;
  List<String>? instructorName;
  int? rating;
  int? courseDuration;
  String? type;
  String? courseType;
  String? level;
  int? lactures;
  List<String>? notes;
  num? averageRating;
  String? courseOverview;
  String? courseStartTime;
  String? courseEndTime;
  String? registrationStartTime;
  String? registrationEndTime;
  String? category;
  String? meetLink;
  String? instructorImage;
  UserMyCoursesData({
    this.sId,
    this.courseName,
    this.slug,
    this.maxEnrolments,
    this.coursePrice,
    this.discountedPrice,
    this.courseImage,
    this.userEnrolled,
    this.topics,
    this.coursePrgress,
    this.instructorName,
    this.rating,
    this.courseDuration,
    this.courseType,
    this.instructorImage,
    this.averageRating,
    this.type,
    this.meetLink,
    this.level,
    this.lactures,
    this.notes,
    this.courseOverview,
    this.courseStartTime,
    this.courseEndTime,
    this.registrationStartTime,
    this.category,
    this.registrationEndTime,
  });

  UserMyCoursesData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['courseName'];
    courseName = json['courseSlug'];
    maxEnrolments = json['maxEnrolments'];
    coursePrice = json['coursePrice'];
    discountedPrice = json['discountedPrice'];
    meetLink = json['meetLink'];
    courseImage = json['courseImage'];
    userEnrolled = json['userEnrolled'];
    averageRating = json['averageRating'];
    courseOverview = json['courseOverview'];
    courseStartTime = json['courseStartTime'];
    courseEndTime = json['courseEndTime'];
    instructorImage = json['instructorImage'];
    registrationStartTime = json['registrationStartTime'];
    registrationEndTime = json['registrationEndTime'];
    category = json['category'];
    if (json['topics'] != null) {
      topics = <UserCoursesTopics>[];
      json['topics'].forEach((v) {
        topics!.add(new UserCoursesTopics.fromJson(v));
      });
    }
    notes = json['notes']?.cast<String>() ?? [];
    coursePrgress = json['coursePrgress'];
    instructorName = json['instructorName'].cast<String>();
    rating = json['rating'];
    courseDuration = json['courseDurationInMinutes'];
    type = json['type'];
    courseType = json['courseType'];
    level = json['level'];
    lactures = json['lectures'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['courseSlug'] = this.slug;
    data['averageRating'] = this.averageRating;
    data['maxEnrolments'] = this.maxEnrolments;
    data['meetLink'] = this.meetLink;
    data['coursePrice'] = this.coursePrice;
    data['instructorImage'] = this.instructorImage;
    data['discountedPrice'] = this.discountedPrice;
    data['courseImage'] = this.courseImage;
    data['userEnrolled'] = this.userEnrolled;
    data['courseOverview'] = this.courseOverview;
    data['courseStartTime'] = this.courseStartTime;
    data['courseEndTime'] = this.courseEndTime;
    data['registrationStartTime'] = this.registrationStartTime;
    data['registrationEndTime'] = this.registrationEndTime;
    data['category'] = this.category;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    data['coursePrgress'] = this.coursePrgress;
    data['instructorName'] = this.instructorName;
    data['notes'] = this.notes;
    data['rating'] = this.rating;
    data['courseDurationInMinutes'] = this.courseDuration;
    data['type'] = this.type;
    data['courseType'] = this.courseType;
    data['level'] = this.level;
    data['lectures'] = this.lactures;
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
  List<String>? notes;

  UserCoursesSubtopics({this.order, this.topic, this.sId, this.notes});

  UserCoursesSubtopics.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    videoUrl = json['videoUrl'];
    videoKey = json['videoKey'];
    sId = json['_id'];
    notes = json['notes']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['topic'] = this.topic;
    data['videoUrl'] = this.videoUrl;
    data['videoKey'] = this.videoKey;
    data['_id'] = this.sId;
    data['notes'] = this.notes;
    return data;
  }
}
