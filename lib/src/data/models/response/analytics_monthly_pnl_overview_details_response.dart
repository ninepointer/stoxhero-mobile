class AnalyticsMonthlyPnLOverviewDetailsResponse {
  String? status;
  List<AnalyticsMonthlyPnLOverviewDetails>? data;

  AnalyticsMonthlyPnLOverviewDetailsResponse({this.status, this.data});

  AnalyticsMonthlyPnLOverviewDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AnalyticsMonthlyPnLOverviewDetails>[];
      json['data'].forEach((v) {
        data!.add(new AnalyticsMonthlyPnLOverviewDetails.fromJson(v));
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

class AnalyticsMonthlyPnLOverviewDetails {
  num? gpnl;
  num? brokerage;
  int? lots;
  int? noOfTrade;
  String? date;
  num? npnl;

  AnalyticsMonthlyPnLOverviewDetails({
    this.gpnl,
    this.brokerage,
    this.lots,
    this.noOfTrade,
    this.date,
    this.npnl,
  });

  AnalyticsMonthlyPnLOverviewDetails.fromJson(Map<String, dynamic> json) {
    gpnl = json['gpnl'];
    brokerage = json['brokerage'];
    lots = json['lots'];
    noOfTrade = json['noOfTrade'];
    date = json['date'];
    npnl = json['npnl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpnl'] = this.gpnl;
    data['brokerage'] = this.brokerage;
    data['lots'] = this.lots;
    data['noOfTrade'] = this.noOfTrade;
    data['date'] = this.date;
    data['npnl'] = this.npnl;
    return data;
  }
}
