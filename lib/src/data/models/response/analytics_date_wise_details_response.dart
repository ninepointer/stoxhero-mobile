class AnalyticsDateWiseDetailsResponse {
  String? status;
  List<AnalyticsDateWiseDetails>? data;

  AnalyticsDateWiseDetailsResponse({
    this.status,
    this.data,
  });

  AnalyticsDateWiseDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AnalyticsDateWiseDetails>[];
      json['data'].forEach((v) {
        data!.add(new AnalyticsDateWiseDetails.fromJson(v));
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

class AnalyticsDateWiseDetails {
  num? gpnl;
  num? brokerage;
  num? lots;
  int? noOfTrade;
  num? npnl;
  String? date;

  AnalyticsDateWiseDetails({
    this.gpnl,
    this.brokerage,
    this.lots,
    this.noOfTrade,
    this.npnl,
    this.date,
  });

  AnalyticsDateWiseDetails.fromJson(Map<String, dynamic> json) {
    gpnl = json['gpnl'];
    brokerage = json['brokerage'];
    lots = json['lots'];
    noOfTrade = json['noOfTrade'];
    npnl = json['npnl'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpnl'] = this.gpnl;
    data['brokerage'] = this.brokerage;
    data['lots'] = this.lots;
    data['noOfTrade'] = this.noOfTrade;
    data['npnl'] = this.npnl;
    data['date'] = this.date;
    return data;
  }
}
