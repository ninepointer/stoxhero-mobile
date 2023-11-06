class TenxTradingPortfolioMarginDetailsResponse {
  String? message;
  TenxPortfolioMarginDetails? data;

  TenxTradingPortfolioMarginDetailsResponse({this.message, this.data});

  TenxTradingPortfolioMarginDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new TenxPortfolioMarginDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TenxPortfolioMarginDetails {
  String? subscriptionId;
  num? totalFund;
  num? npnl;
  num? openingBalance;

  TenxPortfolioMarginDetails({
    this.subscriptionId,
    this.totalFund,
    this.npnl,
    this.openingBalance,
  });

  TenxPortfolioMarginDetails.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    totalFund = json['totalFund'];
    npnl = json['npnl'];
    openingBalance = json['openingBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionId'] = this.subscriptionId;
    data['totalFund'] = this.totalFund;
    data['npnl'] = this.npnl;
    data['openingBalance'] = this.openingBalance;
    return data;
  }
}
