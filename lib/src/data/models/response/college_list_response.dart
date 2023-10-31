class CollegeListResponse {
  String? status;
  List<CollegeData>? data;

  CollegeListResponse({this.status, this.data});

  CollegeListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CollegeData>[];
      json['data'].forEach((v) {
        data!.add(new CollegeData.fromJson(v));
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

class CollegeData {
  String? id;
  String? collegeName;

  CollegeData({this.id, this.collegeName});

  CollegeData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    collegeName = json['collegeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['collegeName'] = this.collegeName;
    return data;
  }
}
