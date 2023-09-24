class MyTenxPortfolioResponse {
  String? status;
  List<MyTenxPortfolio>? data;

  MyTenxPortfolioResponse({this.status, this.data});

  MyTenxPortfolioResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MyTenxPortfolio>[];
      json['data'].forEach((v) {
        data!.add(new MyTenxPortfolio.fromJson(v));
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

class MyTenxPortfolio {
  String? subscriptionId;
  int? portfolioValue;
  String? portfolioType;
  String? portfolioName;
  String? portfolioAccount;
  num? investedAmount;
  num? cashBalance;

  MyTenxPortfolio(
      {this.subscriptionId,
      this.portfolioValue,
      this.portfolioType,
      this.portfolioName,
      this.portfolioAccount,
      this.investedAmount,
      this.cashBalance});

  MyTenxPortfolio.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    portfolioValue = json['portfolioValue'];
    portfolioType = json['portfolioType'];
    portfolioName = json['portfolioName'];
    portfolioAccount = json['portfolioAccount'];
    investedAmount = json['investedAmount'];
    cashBalance = json['cashBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionId'] = this.subscriptionId;
    data['portfolioValue'] = this.portfolioValue;
    data['portfolioType'] = this.portfolioType;
    data['portfolioName'] = this.portfolioName;
    data['portfolioAccount'] = this.portfolioAccount;
    data['investedAmount'] = this.investedAmount;
    data['cashBalance'] = this.cashBalance;
    return data;
  }
}
