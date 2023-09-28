class CareerResponse {
  String? status;
  List<CareerList>? data;

  CareerResponse({this.status, this.data});

  CareerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CareerList>[];
      json['data'].forEach((v) {
        data!.add(new CareerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CareerList {
  String? id;
  String? jobTitle;
  String? jobDescription;
  List<RolesAndResponsibilities>? rolesAndResponsibilities;
  String? jobType;
  String? jobLocation;
  String? status;
  String? listingType;
  String? createdBy;
  String? lastModifiedBy;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;

  CareerList(
      {this.id,
      this.jobTitle,
      this.jobDescription,
      this.rolesAndResponsibilities,
      this.jobType,
      this.jobLocation,
      this.status,
      this.listingType,
      this.createdBy,
      this.lastModifiedBy,
      this.createdOn,
      this.lastModifiedOn,
      this.iV});

  CareerList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
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
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
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
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
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
