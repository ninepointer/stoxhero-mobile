class ContestPortfolioResponse {
  String? status;
  ContestCreditData? data;

  ContestPortfolioResponse({this.status, this.data});

  ContestPortfolioResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new ContestCreditData.fromJson(json['data']) : null;
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

class ContestCreditData {
  String? batch;
  int? totalFund;

  ContestCreditData({this.batch, this.totalFund});

  ContestCreditData.fromJson(Map<String, dynamic> json) {
    batch = json['batch'];
    totalFund = json['totalFund'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch'] = this.batch;
    data['totalFund'] = this.totalFund;
    return data;
  }
}
