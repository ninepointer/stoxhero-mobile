class AnalyticsExpectedPnLOverviewDetailsResponse {
  String? status;
  List<AnalyticsExpectedPnLOverviewDetails>? data;

  AnalyticsExpectedPnLOverviewDetailsResponse({this.status, this.data});

  AnalyticsExpectedPnLOverviewDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AnalyticsExpectedPnLOverviewDetails>[];
      json['data'].forEach((v) {
        data!.add(new AnalyticsExpectedPnLOverviewDetails.fromJson(v));
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

class AnalyticsExpectedPnLOverviewDetails {
  String? sId;
  num? totalGpnl;
  num? totalBrokerage;
  int? numberOfTrades;
  num? npnl;
  num? expectedPnl;
  num? expectedAvgProfit;
  num? expectedAvgLoss;
  num? riskRewardRatio;

  AnalyticsExpectedPnLOverviewDetails(
      {this.sId,
      this.totalGpnl,
      this.totalBrokerage,
      this.numberOfTrades,
      this.npnl,
      this.expectedPnl,
      this.expectedAvgProfit,
      this.expectedAvgLoss,
      this.riskRewardRatio});

  AnalyticsExpectedPnLOverviewDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    totalGpnl = json['total_gpnl'];
    totalBrokerage = json['total_brokerage'];
    numberOfTrades = json['number_of_trades'];
    npnl = json['npnl'];
    expectedPnl = json['expected_pnl'];
    expectedAvgProfit = json['expected_avg_profit'];
    expectedAvgLoss = json['expected_avg_loss'];
    riskRewardRatio = json['riskRewardRatio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['total_gpnl'] = this.totalGpnl;
    data['total_brokerage'] = this.totalBrokerage;
    data['number_of_trades'] = this.numberOfTrades;
    data['npnl'] = this.npnl;
    data['expected_pnl'] = this.expectedPnl;
    data['expected_avg_profit'] = this.expectedAvgProfit;
    data['expected_avg_loss'] = this.expectedAvgLoss;
    data['riskRewardRatio'] = this.riskRewardRatio;
    return data;
  }
}
