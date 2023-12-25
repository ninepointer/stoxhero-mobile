class MyAffiliateRefferalsListResponse {
  String? status;
  List<MyAffiliateRefferal>? data;
  int? count;

  MyAffiliateRefferalsListResponse({
    this.status,
    this.data,
    this.count,
  });

  MyAffiliateRefferalsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MyAffiliateRefferal>[];
      json['data'].forEach((v) {
        data!.add(new MyAffiliateRefferal.fromJson(v));
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

class MyAffiliateRefferal {
  String? name;
  String? joiningDate;
  num? payout;

  MyAffiliateRefferal({
    this.name,
    this.joiningDate,
    this.payout,
  });

  MyAffiliateRefferal.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    joiningDate = json['joining_date'];
    payout = json['payout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['joining_date'] = this.joiningDate;
    data['payout'] = this.payout;
    return data;
  }
}
