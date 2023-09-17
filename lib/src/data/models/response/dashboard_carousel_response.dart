class DashboardCarouselResponse {
  String? status;
  List<DashboardCarousel>? data;
  int? count;

  DashboardCarouselResponse({this.status, this.data, this.count});

  DashboardCarouselResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DashboardCarousel>[];
      json['data'].forEach((v) {
        data!.add(new DashboardCarousel.fromJson(v));
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

class DashboardCarousel {
  String? sId;
  String? carouselName;
  String? description;
  String? carouselStartDate;
  String? carouselEndDate;
  int? carouselPosition;
  String? window;
  String? visibility;
  String? status;
  bool? clickable;
  String? linkToCarousel;
  String? carouselImage;
  String? createdBy;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;

  DashboardCarousel(
      {this.sId,
      this.carouselName,
      this.description,
      this.carouselStartDate,
      this.carouselEndDate,
      this.carouselPosition,
      this.window,
      this.visibility,
      this.status,
      this.clickable,
      this.linkToCarousel,
      this.carouselImage,
      this.createdBy,
      this.createdOn,
      this.lastModifiedOn,
      this.iV});

  DashboardCarousel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carouselName = json['carouselName'];
    description = json['description'];
    carouselStartDate = json['carouselStartDate'];
    carouselEndDate = json['carouselEndDate'];
    carouselPosition = json['carouselPosition'];
    window = json['window'];
    visibility = json['visibility'];
    status = json['status'];
    clickable = json['clickable'];
    linkToCarousel = json['linkToCarousel'];
    carouselImage = json['carouselImage'];
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['carouselName'] = this.carouselName;
    data['description'] = this.description;
    data['carouselStartDate'] = this.carouselStartDate;
    data['carouselEndDate'] = this.carouselEndDate;
    data['carouselPosition'] = this.carouselPosition;
    data['window'] = this.window;
    data['visibility'] = this.visibility;
    data['status'] = this.status;
    data['clickable'] = this.clickable;
    data['linkToCarousel'] = this.linkToCarousel;
    data['carouselImage'] = this.carouselImage;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    return data;
  }
}
