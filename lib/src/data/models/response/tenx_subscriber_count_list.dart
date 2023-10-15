class TenxSubscriberCountListResponse {
  String? status;
  List<TenxSubscriberCountList>? data;

  TenxSubscriberCountListResponse({this.status, this.data});

  TenxSubscriberCountListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxSubscriberCountList>[];
      json['data'].forEach((v) {
        data!.add(new TenxSubscriberCountList.fromJson(v));
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

class TenxSubscriberCountList {
  String? id;
  int? count;

  TenxSubscriberCountList({this.id, this.count});

  TenxSubscriberCountList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['count'] = this.count;
    return data;
  }
}
