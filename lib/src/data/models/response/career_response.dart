class CareerResponse {
  String? message;
  List<CareerList>? data;

  CareerResponse({this.message, this.data});

  CareerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <CareerList>[];
      json['data'].forEach((v) {
        data!.add(new CareerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CareerList {
  String? sId;
  String? jobTitle;
  String? jobDescription;
  List<RolesAndResponsibilities>? rolesAndResponsibilities;
  String? jobType;
  String? jobLocation;
  String? status;
  String? listingType;
  List<Applicants>? applicants;

  CareerList({
    this.sId,
    this.jobTitle,
    this.jobDescription,
    this.rolesAndResponsibilities,
    this.jobType,
    this.jobLocation,
    this.status,
    this.listingType,
    // this.applicants,
  });

  CareerList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jobTitle = json['jobTitle'];
    jobDescription = json['jobDescription'];
    if (json['rolesAndResponsibilities'] != null) {
      rolesAndResponsibilities = <RolesAndResponsibilities>[];
      json['rolesAndResponsibilities'].forEach((v) {
        rolesAndResponsibilities!.add(new RolesAndResponsibilities.fromJson(v));
      });
    }
    jobType = json['jobType'];
    jobLocation = json['jobLocation'];
    status = json['status'];
    listingType = json['listingType'];
    if (json['applicants'] != null) {
      applicants = <Applicants>[];
      json['applicants'].forEach((v) {
        applicants!.add(new Applicants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['jobTitle'] = this.jobTitle;
    data['jobDescription'] = this.jobDescription;
    if (this.rolesAndResponsibilities != null) {
      data['rolesAndResponsibilities'] =
          this.rolesAndResponsibilities!.map((v) => v.toJson()).toList();
    }
    data['jobType'] = this.jobType;
    data['jobLocation'] = this.jobLocation;
    data['status'] = this.status;
    data['listingType'] = this.listingType;
    if (this.applicants != null) {
      data['applicants'] = this.applicants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RolesAndResponsibilities {
  int? orderNo;
  String? description;
  String? sId;

  RolesAndResponsibilities({this.orderNo, this.description, this.sId});

  RolesAndResponsibilities.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    description = json['description'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['description'] = this.description;
    data['_id'] = this.sId;
    return data;
  }
}

class Applicants {
  String? sId;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? email;
  String? dob;
  String? career;
  String? priorTradingExperience;
  String? collegeName;
  String? linkedInProfileLink;
  String? source;
  String? campaignCode;
  String? mobileOtp;
  String? status;
  String? applicationStatus;
  String? appliedOn;
  int? iV;

  Applicants(
      {this.sId,
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.email,
      this.dob,
      this.career,
      this.priorTradingExperience,
      this.collegeName,
      this.linkedInProfileLink,
      this.source,
      this.campaignCode,
      this.mobileOtp,
      this.status,
      this.applicationStatus,
      this.appliedOn,
      this.iV});

  Applicants.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobileNo'];
    email = json['email'];
    dob = json['dob'];
    career = json['career'];
    priorTradingExperience = json['priorTradingExperience'];
    collegeName = json['collegeName'];
    linkedInProfileLink = json['linkedInProfileLink'];
    source = json['source'];
    campaignCode = json['campaignCode'];
    mobileOtp = json['mobile_otp'];
    status = json['status'];
    applicationStatus = json['applicationStatus'];
    appliedOn = json['appliedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobileNo'] = this.mobileNo;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['career'] = this.career;
    data['priorTradingExperience'] = this.priorTradingExperience;
    data['collegeName'] = this.collegeName;
    data['linkedInProfileLink'] = this.linkedInProfileLink;
    data['source'] = this.source;
    data['campaignCode'] = this.campaignCode;
    data['mobile_otp'] = this.mobileOtp;
    data['status'] = this.status;
    data['applicationStatus'] = this.applicationStatus;
    data['appliedOn'] = this.appliedOn;
    data['__v'] = this.iV;
    return data;
  }
}
