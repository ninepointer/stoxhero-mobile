class PortfolioResponse {
  String? status;
  List<Portfolio>? data;
  int? results;

  PortfolioResponse({
    this.status,
    this.data,
    this.results,
  });

  PortfolioResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Portfolio>[];
      json['data'].forEach((v) {
        data!.add(new Portfolio.fromJson(v));
      });
    }
    results = json['results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['results'] = this.results;
    return data;
  }
}

class Portfolio {
  String? sId;
  String? portfolioName;
  String? status;
  int? portfolioValue;
  String? portfolioAccount;
  String? portfolioType;
  int? investedAmount;
  int? cashBalance;

  Portfolio(
      {this.sId,
      this.portfolioName,
      this.status,
      this.portfolioValue,
      this.portfolioAccount,
      this.portfolioType,
      this.investedAmount,
      this.cashBalance});

  Portfolio.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    portfolioName = json['portfolioName'];
    status = json['status'];
    portfolioValue = json['portfolioValue'];
    portfolioAccount = json['portfolioAccount'];
    portfolioType = json['portfolioType'];
    investedAmount = json['investedAmount'];
    cashBalance = json['cashBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['portfolioName'] = this.portfolioName;
    data['status'] = this.status;
    data['portfolioValue'] = this.portfolioValue;
    data['portfolioAccount'] = this.portfolioAccount;
    data['portfolioType'] = this.portfolioType;
    data['investedAmount'] = this.investedAmount;
    data['cashBalance'] = this.cashBalance;
    return data;
  }
}
