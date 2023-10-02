class MarginXPortfolioResponse {
  String? status;
  MarginXPortfolio? data;

  MarginXPortfolioResponse({this.status, this.data});

  MarginXPortfolioResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new MarginXPortfolio.fromJson(json['data']) : null;
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

class MarginXPortfolio {
  String? marginx;
  int? totalFund;

  MarginXPortfolio({this.marginx, this.totalFund});

  MarginXPortfolio.fromJson(Map<String, dynamic> json) {
    marginx = json['marginx'];
    totalFund = json['totalFund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marginx'] = this.marginx;
    data['totalFund'] = this.totalFund;
    return data;
  }
}
