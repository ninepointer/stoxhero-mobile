class StocksFundsMarginResponse {
  String? message;
  FundsMargin? data;

  StocksFundsMarginResponse({this.message, this.data});

  StocksFundsMarginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new FundsMargin.fromJson(json['data']) : null;
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

class FundsMargin {
  String? portfolioId;
  String? portfolioName;
  num? totalFund;
  num? npnl;
  num? openingBalance;

  FundsMargin(
      {this.portfolioId,
      this.portfolioName,
      this.totalFund,
      this.npnl,
      this.openingBalance});

  FundsMargin.fromJson(Map<String, dynamic> json) {
    portfolioId = json['portfolioId'];
    portfolioName = json['portfolioName'];
    totalFund = json['totalFund'];
    npnl = json['npnl'];
    openingBalance = json['openingBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portfolioId'] = this.portfolioId;
    data['portfolioName'] = this.portfolioName;
    data['totalFund'] = this.totalFund;
    data['npnl'] = this.npnl;
    data['openingBalance'] = this.openingBalance;
    return data;
  }
}
