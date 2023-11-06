class InternshipBatchPortfolioResponse {
  String? message;
  InternshipBatchPortfolio? data;

  InternshipBatchPortfolioResponse({this.message, this.data});

  InternshipBatchPortfolioResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new InternshipBatchPortfolio.fromJson(json['data']) : null;
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

class InternshipBatchPortfolio {
  String? batch;
  num? totalFund;
  num? npnl;
  num? openingBalance;

  InternshipBatchPortfolio({this.batch, this.totalFund, this.npnl, this.openingBalance});

  InternshipBatchPortfolio.fromJson(Map<String, dynamic> json) {
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
