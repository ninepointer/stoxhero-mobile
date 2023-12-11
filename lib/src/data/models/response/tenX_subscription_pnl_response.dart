class TenxSubscribedPlanPNLResponse {
  String? message;
  List<TenxSubscribedPlanPnl>? data;

  TenxSubscribedPlanPNLResponse({this.message, this.data});

  TenxSubscribedPlanPNLResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TenxSubscribedPlanPnl>[];
      json['data'].forEach((v) {
        data!.add(new TenxSubscribedPlanPnl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TenxSubscribedPlanPnl {
  int? trades;
  num? grossPnl;
  num? brokerage;
  num? npnl;
  int? tradingDays;

  TenxSubscribedPlanPnl(
      {this.trades,
      this.grossPnl,
      this.brokerage,
      this.npnl,
      this.tradingDays});

  TenxSubscribedPlanPnl.fromJson(Map<String, dynamic> json) {
    trades = json['trades'];
    grossPnl = json['grossPnl'];
    brokerage = json['brokerage'];
    npnl = json['npnl'];
    tradingDays = json['tradingDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trades'] = this.trades;
    data['grossPnl'] = this.grossPnl;
    data['brokerage'] = this.brokerage;
    data['npnl'] = this.npnl;
    data['tradingDays'] = this.tradingDays;
    return data;
  }
}
