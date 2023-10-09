class ContestPortfolioResponse {
  String? message;
  ContestCreditData? data;

  ContestPortfolioResponse({this.message, this.data});

  ContestPortfolioResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ContestCreditData.fromJson(json['data']) : null;
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

class ContestCreditData {
  String? batch;
  int? totalFund;
  num? npnl;
  num? openingBalance;

  ContestCreditData({this.batch, this.totalFund, this.npnl, this.openingBalance});

  ContestCreditData.fromJson(Map<String, dynamic> json) {
    batch = json['batch'];
    totalFund = json['totalFund'];
    npnl = json['npnl'];
    openingBalance = json['openingBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch'] = this.batch;
    data['totalFund'] = this.totalFund;
    data['npnl'] = this.npnl;
    data['openingBalance'] = this.openingBalance;
    return data;
  }
}
