class InfluencerCourseResponse {
  String? status;
  List<InfluencerCourseData>? data;
  List<InfluencerCourseData>? workshop;

  int? count;

  InfluencerCourseResponse({this.status, this.data, this.count});

  InfluencerCourseResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['workshop'] != null) {
      workshop = <InfluencerCourseData>[];
      json['workshop'].forEach((v) {
        workshop!.add(new InfluencerCourseData.fromJson(v));
      });
    }
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
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.map((v) => v.toJson()).toList();
    }

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Workshop {
  String? sId;
  String? courseName;
  String? courseSlug;
  String? courseImage;
  int? courseDurationInMinutes;
  String? type;
  String? courseType;
  String? category;
  String? level;
  int? discountedPrice;
  int? coursePrice;
  int? maxEnrolments;
  int? userEnrolled;
  int? lectures;
  List<WorkshopTopics>? topics;
  String? courseEndTime;

  int? courseProgress;
  List<String>? instructorName;
  int? rating;

  Workshop(
      {this.sId,
      this.courseName,
      this.courseSlug,
      this.courseImage,
      this.courseDurationInMinutes,
      this.type,
      this.courseType,
      this.category,
      this.level,
      this.courseEndTime,
      this.discountedPrice,
      this.coursePrice,
      this.maxEnrolments,
      this.userEnrolled,
      this.lectures,
      this.topics,
      this.courseProgress,
      this.instructorName,
      this.rating});

  Workshop.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['courseName'];
    courseSlug = json['courseSlug'];
    courseImage = json['courseImage'];
    courseDurationInMinutes = json['courseDurationInMinutes'];
    type = json['type'];
    courseType = json['courseType'];
    category = json['category'];
    level = json['level'];
    courseEndTime = json['courseEndTime'];
    discountedPrice = json['discountedPrice'];
    coursePrice = json['coursePrice'];
    maxEnrolments = json['maxEnrolments'];
    userEnrolled = json['userEnrolled'];
    lectures = json['lectures'];
    if (json['topics'] != null) {
      topics = <WorkshopTopics>[];
      json['topics'].forEach((v) {
        topics!.add(new WorkshopTopics.fromJson(v));
      });
    }
    courseProgress = json['courseProgress'];
    instructorName = json['instructorName'].cast<String>();
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['courseSlug'] = this.courseSlug;
    data['courseImage'] = this.courseImage;
    data['courseDurationInMinutes'] = this.courseDurationInMinutes;
    data['type'] = this.type;
    data['courseType'] = this.courseType;
    data['category'] = this.category;
    data['level'] = this.level;
    data['courseEndTime'] = this.courseEndTime;
    data['discountedPrice'] = this.discountedPrice;
    data['coursePrice'] = this.coursePrice;
    data['maxEnrolments'] = this.maxEnrolments;
    data['userEnrolled'] = this.userEnrolled;
    data['lectures'] = this.lectures;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    data['courseProgress'] = this.courseProgress;
    data['instructorName'] = this.instructorName;
    data['rating'] = this.rating;
    return data;
  }
}

class InfluencerCourseData {
  String? sId;
  String? courseName;
  String? courseStartTime;
  String? registrationEndTime;
  int? maxEnrolments;
  String? courseImage;
  String? instructorImage;
  int? userEnrolled;
  num? coursePrice;
  num? discountedPrice;
  List<WorkshopTopics>? topics;
  List<String>? instructorName;
  num? averageRating;
  num? lectures;
  String? level;
  num? courseDurationInMinutes;
  bool? isPaid;
  String? meetLink;
  String? courseLanguages;
  String? courseEndTime;
  InfluencerCourseData(
      {this.sId,
      this.courseName,
      this.courseStartTime,
      this.maxEnrolments,
      this.courseImage,
      this.userEnrolled,
      this.instructorImage,
      this.coursePrice,
      this.discountedPrice,
      this.meetLink,
      this.courseEndTime,
      this.instructorName,
      this.averageRating,
      this.topics,
      this.lectures,
      this.courseLanguages,
      this.registrationEndTime,
      this.level,
      this.courseDurationInMinutes,
      this.isPaid});

  InfluencerCourseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    meetLink = json['meetLink'];
    courseName = json['courseName'];
    courseStartTime = json['courseStartTime'];
    maxEnrolments = json['maxEnrolments'];
    courseImage = json['courseImage'];
    courseEndTime = json['courseEndTime'];
    instructorImage = json['instructorImage'];
    userEnrolled = json['userEnrolled'];
    registrationEndTime = json['registrationEndTime'];
    courseLanguages = json['courseLanguages'];
    coursePrice = json['coursePrice'] != null ? json['coursePrice'] : null;
    discountedPrice =
        json['discountedPrice'] != null ? json['discountedPrice'] : null;
    instructorName = json['instructorName'] != null
        ? List<String>.from(json["instructorName"].map((x) => x))
        : null;
    if (json['topics'] != null) {
      topics = <WorkshopTopics>[];
      json['topics'].forEach((v) {
        topics!.add(new WorkshopTopics.fromJson(v));
      });
    }
    averageRating = json['averageRating'];
    lectures = json["lectures"];
    level = json['level'];
    courseDurationInMinutes = json['courseDurationInMinutes'];
    isPaid = json['isPaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['courseStartTime'] = this.courseStartTime;
    data['maxEnrolments'] = this.maxEnrolments;
    data['courseImage'] = this.courseImage;
    data['meetLink'] = meetLink;
    data['courseEndTime'] = courseEndTime;
    data['registrationEndTime'] = registrationEndTime;
    data['userEnrolled'] = this.userEnrolled;
    data['instructorName'] = this.instructorName;
    data['instructorImage'] = this.instructorImage;
    data['averageRating'] = this.averageRating;
    data['courseLanguages'] = this.courseLanguages;
    data['lectures'] = this.lectures;
    data['level'] = this.level;
    data['courseDurationInMinutes'] = this.courseDurationInMinutes;
    data['isPaid'] = this.isPaid;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkshopTopics {
  int? order;
  String? topic;
  List<WorkshopSubtopics>? subtopics;
  String? sId;

  WorkshopTopics({this.order, this.topic, this.subtopics, this.sId});

  WorkshopTopics.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    if (json['subtopics'] != null) {
      subtopics = <WorkshopSubtopics>[];
      json['subtopics'].forEach((v) {
        subtopics!.add(new WorkshopSubtopics.fromJson(v));
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

class WorkshopSubtopics {
  int? order;
  String? topic;
  String? videoUrl;
  String? videoKey;
  List<String>? notes;
  String? sId;

  WorkshopSubtopics(
      {this.order,
      this.topic,
      this.videoUrl,
      this.videoKey,
      this.notes,
      this.sId});

  WorkshopSubtopics.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    videoUrl = json['videoUrl'];
    videoKey = json['videoKey'];
    notes = json['notes'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['topic'] = this.topic;
    data['videoUrl'] = this.videoUrl;
    data['videoKey'] = this.videoKey;
    data['notes'] = this.notes;
    data['_id'] = this.sId;
    return data;
  }
}
