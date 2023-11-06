class EarningsResponse {
  String? status;
  EarningData? data;

  EarningsResponse({
    this.status,
    this.data,
  });

  EarningsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new EarningData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class EarningData {
  num? joined;
  num? earnings;

  EarningData({this.joined, this.earnings});

  EarningData.fromJson(Map<String, dynamic> json) {
    joined = json['joined'];
    earnings = json['earnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['joined'] = this.joined;
    data['earnings'] = this.earnings;
    return data;
  }
}
