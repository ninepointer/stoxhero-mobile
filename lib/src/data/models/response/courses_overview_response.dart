class CourseOverviewResponse {
  CourseOverViewData? data;
  String? status;

  CourseOverviewResponse({this.data, this.status});

  CourseOverviewResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new CourseOverViewData.fromJson(json['data'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class CourseOverViewData {
  String? sId;
  String? courseName;
  String? courseSlug;
  String? courseImage;
  String? courseLanguages;
  int? courseDurationInMinutes;
  String? courseOverview;
  String? courseDescription;
  String? courseEndTime;
  String? courseStartTime;
  String? registrationStartTime;
  String? registrationEndTime;
  int? maxEnrolments;
  String? status;
  String? type;
  String? courseType;
  String? category;
  List<String>? tags;
  String? level;
  String? salesVideo;
  List<CourseInstructors>? courseInstructors;
  List<CourseBenefits>? courseBenefits;
  List<CourseContent>? courseContent;
  List<Enrollments>? enrollments;
  List<Faqs>? faqs;
  int? iV;
  int? commissionPercentage;
  int? coursePrice;
  int? discountedPrice;
  List<String>? suggestChanges;
  List<Ratings>? ratings;
  num? averageRating;
  String? meetLink;

  CourseOverViewData(
      {this.sId,
      this.courseName,
      this.courseSlug,
      this.courseImage,
      this.courseLanguages,
      this.courseDurationInMinutes,
      this.courseOverview,
      this.courseDescription,
      this.courseStartTime,
      this.courseEndTime,
      this.meetLink,
      this.registrationStartTime,
      this.registrationEndTime,
      this.maxEnrolments,
      this.status,
      this.type,
      this.courseType,
      this.category,
      this.tags,
      this.level,
      this.salesVideo,
      this.courseInstructors,
      this.courseBenefits,
      this.courseContent,
      this.enrollments,
      this.faqs,
      this.iV,
      this.commissionPercentage,
      this.coursePrice,
      this.discountedPrice,
      this.ratings,
      this.averageRating,
      this.suggestChanges});

  CourseOverViewData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    courseName = json['courseName'];
    courseSlug = json['courseSlug'];
    courseImage = json['courseImage'];
    courseLanguages = json['courseLanguages'];
    courseDurationInMinutes = json['courseDurationInMinutes'];
    courseOverview = json['courseOverview'];
    courseDescription = json['courseDescription'];
    meetLink = json['meetLink'];
    courseEndTime = json['courseEndTime'];
    courseStartTime = json['courseStartTime'];
    registrationStartTime = json['registrationStartTime'];
    registrationEndTime = json['registrationEndTime'];
    maxEnrolments = json['maxEnrolments'];
    if (json['averageRating'] != null) {
      averageRating = json['averageRating'];
    }
    status = json['status'];
    type = json['type'];
    courseType = json['courseType'];
    category = json['category'];
    tags = json['tags'].cast<String>();
    level = json['level'];
    salesVideo = json['salesVideo'];
    if (json['courseInstructors'] != null) {
      courseInstructors = <CourseInstructors>[];
      json['courseInstructors'].forEach((v) {
        courseInstructors!.add(new CourseInstructors.fromJson(v));
      });
    }
    if (json['courseBenefits'] != null) {
      courseBenefits = <CourseBenefits>[];
      json['courseBenefits'].forEach((v) {
        courseBenefits!.add(new CourseBenefits.fromJson(v));
      });
    }
    if (json['courseContent'] != null) {
      courseContent = <CourseContent>[];
      json['courseContent'].forEach((v) {
        courseContent!.add(new CourseContent.fromJson(v));
      });
    }
    if (json['enrollments'] != null) {
      enrollments = <Enrollments>[];
      json['enrollments'].forEach((v) {
        enrollments!.add(new Enrollments.fromJson(v));
      });
    }
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(new Faqs.fromJson(v));
      });
    }
    if (json['ratings'] != null && json['ratings'] is List) {
      ratings = <Ratings>[];
      (json['ratings'] as List).forEach((v) {
        if (v is Map<String, dynamic>) {
          ratings!.add(new Ratings.fromJson(v));
        }
      });
    }

    iV = json['__v'];
    commissionPercentage = json['commissionPercentage'];
    coursePrice = json['coursePrice'];
    discountedPrice = json['discountedPrice'];
    suggestChanges = json['suggestChanges'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['courseName'] = this.courseName;
    data['courseSlug'] = this.courseSlug;
    data['courseImage'] = this.courseImage;
    data['courseLanguages'] = this.courseLanguages;
    data['courseDurationInMinutes'] = this.courseDurationInMinutes;
    data['courseOverview'] = this.courseOverview;
    data['meetLink'] = this.meetLink;
    data['courseDescription'] = this.courseDescription;
    data['courseStartTime'] = this.courseStartTime;
    data['courseEndTime'] = this.courseEndTime;
    data['registrationStartTime'] = this.registrationStartTime;
    data['registrationEndTime'] = this.registrationEndTime;
    data['maxEnrolments'] = this.maxEnrolments;
    data['status'] = this.status;
    data['type'] = this.type;
    data['courseType'] = this.courseType;
    data['category'] = this.category;
    data['tags'] = this.tags;
    data['level'] = this.level;
    data['salesVideo'] = this.salesVideo;
    data['averageRating'] = this.averageRating;
    if (this.courseInstructors != null) {
      data['courseInstructors'] =
          this.courseInstructors!.map((v) => v.toJson()).toList();
    }
    if (this.courseBenefits != null) {
      data['courseBenefits'] =
          this.courseBenefits!.map((v) => v.toJson()).toList();
    }
    if (this.courseContent != null) {
      data['courseContent'] =
          this.courseContent!.map((v) => v.toJson()).toList();
    }
    if (this.enrollments != null) {
      data['enrollments'] = this.enrollments!.map((v) => v.toJson()).toList();
    }
    if (this.faqs != null) {
      data['faqs'] = this.faqs!.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['commissionPercentage'] = this.commissionPercentage;
    data['coursePrice'] = this.coursePrice;
    data['discountedPrice'] = this.discountedPrice;
    data['suggestChanges'] = this.suggestChanges;
    return data;
  }
}

class CourseInstructors {
  InstructorId? id;
  String? image;
  String? about;
  String? sId;

  CourseInstructors({this.id, this.image, this.about, this.sId});

  CourseInstructors.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new InstructorId.fromJson(json['id']) : null;
    image = json['image'];
    about = json['about'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    data['image'] = this.image;
    data['about'] = this.about;
    data['_id'] = this.sId;
    return data;
  }
}

class InstructorId {
  String? sId;
  String? email;
  String? firstName;
  String? lastName;

  InstructorId({this.sId, this.email, this.firstName, this.lastName});

  InstructorId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class CourseBenefits {
  int? order;
  String? benefits;
  String? sId;

  CourseBenefits({this.order, this.benefits, this.sId});

  CourseBenefits.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    benefits = json['benefits'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['benefits'] = this.benefits;
    data['_id'] = this.sId;
    return data;
  }
}

class CourseContent {
  int? order;
  String? topic;
  List<Subtopics>? subtopics;
  String? sId;

  CourseContent({this.order, this.topic, this.subtopics, this.sId});

  CourseContent.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    if (json['subtopics'] != null) {
      subtopics = <Subtopics>[];
      json['subtopics'].forEach((v) {
        subtopics!.add(new Subtopics.fromJson(v));
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

class Subtopics {
  int? order;
  String? topic;
  String? sId;

  Subtopics({this.order, this.topic, this.sId});

  Subtopics.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    topic = json['topic'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['topic'] = this.topic;
    data['_id'] = this.sId;
    return data;
  }
}

class Enrollments {
  CourseUserId? userId;
  int? fee;
  int? actualPrice;
  String? enrolledOn;
  num? bonusRedemption;

  Enrollments(
      {this.userId,
      this.fee,
      this.actualPrice,
      this.enrolledOn,
      this.bonusRedemption});

  Enrollments.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null
        ? new CourseUserId.fromJson(json['userId'])
        : null;
    fee = json['fee'];
    actualPrice = json['actualPrice'];
    enrolledOn = json['enrolledOn'];
    bonusRedemption = json['bonusRedemption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['fee'] = this.fee;
    data['actualPrice'] = this.actualPrice;
    data['enrolledOn'] = this.enrolledOn;
    data['bonusRedemption'] = this.bonusRedemption;
    return data;
  }
}

class CourseUserId {
  String? sId;
  String? firstName;
  String? lastName;
  String? creationProcess;

  CourseUserId({this.sId, this.firstName, this.lastName, this.creationProcess});

  CourseUserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    creationProcess = json['creationProcess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['creationProcess'] = this.creationProcess;
    return data;
  }
}

class Faqs {
  int? order;
  String? question;
  String? answer;
  String? sId;

  Faqs({this.order, this.question, this.answer, this.sId});

  Faqs.fromJson(Map<String, dynamic> json) {
    order = json['order'];
    question = json['question'];
    answer = json['answer'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order'] = this.order;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['_id'] = this.sId;
    return data;
  }
}

class Ratings {
  String? sId;
  num? rating;
  String? userId;
  String? ratingDate;

  Ratings({this.sId, this.rating, this.userId, this.ratingDate});

  Ratings.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rating = json['rating'];
    userId = json['userId'];
    ratingDate = json['ratingDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['rating'] = this.rating;
    data['userId'] = this.userId;
    data['ratingDate'] = this.ratingDate;
    return data;
  }
}
