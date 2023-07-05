class TenxTradingPortfolioDetailsResponse {
  String? status;
  TenxTradingPortfolioDetails? data;

  TenxTradingPortfolioDetailsResponse({this.status, this.data});

  TenxTradingPortfolioDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new TenxTradingPortfolioDetails.fromJson(json['data']) : null;
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

class TenxTradingPortfolioDetails {
  String? subscriptionId;
  num? totalFund;
  num? npnl;
  num? openingBalance;

  TenxTradingPortfolioDetails({this.subscriptionId, this.totalFund, this.npnl, this.openingBalance});

  TenxTradingPortfolioDetails.fromJson(Map<String, dynamic> json) {
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
