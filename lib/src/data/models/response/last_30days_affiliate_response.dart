class Last30DaysAffiliateDataResponse {
  String? status;
  List<AffiliateLast30DaysData>? data;

  Last30DaysAffiliateDataResponse({this.status, this.data});

  Last30DaysAffiliateDataResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AffiliateLast30DaysData>[];
      json['data'].forEach((v) {
        data!.add(new AffiliateLast30DaysData.fromJson(v));
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

class AffiliateLast30DaysData {
  String? sId;
  int? totalOrder;
  num? totalSignupEarnings;
  num? totalTestzoneEarnings;
  num? totalTenxEarnings;
  num? totalEarnings;

  AffiliateLast30DaysData(
      {this.sId,
      this.totalOrder,
      this.totalSignupEarnings,
      this.totalTestzoneEarnings,
      this.totalTenxEarnings,
      this.totalEarnings});

  AffiliateLast30DaysData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalOrder = json['totalOrder'];
    totalSignupEarnings = json['totalSignupEarnings'];
    totalTestzoneEarnings = json['totalTestzoneEarnings'];
    totalTenxEarnings = json['totalTenxEarnings'];
    totalEarnings = json['totalEarnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['totalOrder'] = this.totalOrder;
    data['totalSignupEarnings'] = this.totalSignupEarnings;
    data['totalTestzoneEarnings'] = this.totalTestzoneEarnings;
    data['totalTenxEarnings'] = this.totalTenxEarnings;
    data['totalEarnings'] = this.totalEarnings;
    return data;
  }
}
