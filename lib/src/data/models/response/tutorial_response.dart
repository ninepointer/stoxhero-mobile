class TutorialResponse {
  String? status;
  List<Tutorials>? data;
  int? results;

  TutorialResponse({this.status, this.data, this.results});

  TutorialResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Tutorials>[];
      json['data'].forEach((v) {
        data!.add(new Tutorials.fromJson(v));
      });
    }
    results = json['results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['results'] = this.results;
    return data;
  }
}

class Tutorials {
  String? sId;
  String? categoryName;
  String? description;
  String? status;
  bool? isDeleted;
  String? createdOn;
  String? lastModifiedOn;
  String? createdBy;
  String? lastModifiedBy;
  List<CategoryVideos>? categoryVideos;
  int? iV;

  Tutorials(
      {this.sId,
      this.categoryName,
      this.description,
      this.status,
      this.isDeleted,
      this.createdOn,
      this.lastModifiedOn,
      this.createdBy,
      this.lastModifiedBy,
      this.categoryVideos,
      this.iV});

  Tutorials.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
    description = json['description'];
    status = json['status'];
    isDeleted = json['isDeleted'];
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    if (json['categoryVideos'] != null) {
      categoryVideos = <CategoryVideos>[];
      json['categoryVideos'].forEach((v) {
        categoryVideos!.add(new CategoryVideos.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    if (this.categoryVideos != null) {
      data['categoryVideos'] = this.categoryVideos!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class CategoryVideos {
  String? title;
  String? videoId;
  bool? isDeleted;
  String? sId;

  CategoryVideos({this.title, this.videoId, this.isDeleted, this.sId});

  CategoryVideos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videoId = json['videoId'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['videoId'] = this.videoId;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    return data;
  }
}
