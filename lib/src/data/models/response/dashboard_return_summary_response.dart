class DashboardReturnSummaryResponse {
  String? status;
  DashboardReturnSummary? data;

  DashboardReturnSummaryResponse({this.status, this.data});

  DashboardReturnSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DashboardReturnSummary.fromJson(json['data']) : null;
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

class DashboardReturnSummary {
  int? totalTenXPortfolioValue;
  TenxData? tenxData;
  VirtualData? virtualData;
  num? contestReturn;
  num? tenxReturn;

  DashboardReturnSummary(
      {this.totalTenXPortfolioValue,
      this.tenxData,
      this.virtualData,
      this.contestReturn,
      this.tenxReturn});

  DashboardReturnSummary.fromJson(Map<String, dynamic> json) {
    totalTenXPortfolioValue = json['totalTenXPortfolioValue'];
    tenxData = json['tenxData'] != null ? new TenxData.fromJson(json['tenxData']) : null;
    virtualData =
        json['virtualData'] != null ? new VirtualData.fromJson(json['virtualData']) : null;
    contestReturn = json['contestReturn'];
    tenxReturn = json['tenxReturn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalTenXPortfolioValue'] = this.totalTenXPortfolioValue;
    if (this.tenxData != null) {
      data['tenxData'] = this.tenxData!.toJson();
    }
    if (this.virtualData != null) {
      data['virtualData'] = this.virtualData!.toJson();
    }
    data['contestReturn'] = this.contestReturn;
    data['tenxReturn'] = this.tenxReturn;
    return data;
  }
}

class TenxData {
  TId? iId;
  String? date;
  num? npnl;
  int? portfolio;

  TenxData({this.iId, this.date, this.npnl, this.portfolio});

  TenxData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new TId.fromJson(json['_id']) : null;
    date = json['date'];
    npnl = json['npnl'];
    portfolio = json['portfolio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['date'] = this.date;
    data['npnl'] = this.npnl;
    data['portfolio'] = this.portfolio;
    return data;
  }
}

class TId {
  String? tradeTime;
  String? subscriptionId;

  TId({this.tradeTime, this.subscriptionId});

  TId.fromJson(Map<String, dynamic> json) {
    tradeTime = json['trade_time'];
    subscriptionId = json['subscriptionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trade_time'] = this.tradeTime;
    data['subscriptionId'] = this.subscriptionId;
    return data;
  }
}

class VirtualData {
  String? nId;
  num? totalGpnl;
  num? totalBrokerage;
  int? numberOfTrades;
  String? portfolio;
  num? npnl;

  VirtualData(
      {this.nId,
      this.totalGpnl,
      this.totalBrokerage,
      this.numberOfTrades,
      this.portfolio,
      this.npnl});

  VirtualData.fromJson(Map<String, dynamic> json) {
    nId = json['_id'];
    totalGpnl = json['total_gpnl'];
    totalBrokerage = json['total_brokerage'];
    numberOfTrades = json['number_of_trades'];
    portfolio = json['portfolio'];
    npnl = json['npnl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.nId;
    data['total_gpnl'] = this.totalGpnl;
    data['total_brokerage'] = this.totalBrokerage;
    data['number_of_trades'] = this.numberOfTrades;
    data['portfolio'] = this.portfolio;
    data['npnl'] = this.npnl;
    return data;
  }
}
