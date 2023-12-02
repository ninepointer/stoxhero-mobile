import '../../../app/app.dart';

class TenxExpiredPlanListResponse {
  String? status;
  List<TenxExpiredPlan>? data;

  TenxExpiredPlanListResponse({this.status, this.data});

  TenxExpiredPlanListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxExpiredPlan>[];
      json['data'].forEach((v) {
        data!.add(new TenxExpiredPlan.fromJson(v));
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

class TenxExpiredPlan {
  String? sId;
  String? planName;
  int? expiryDays;
  num? payoutPercentage;
  List<Features>? features;
  num? portfolioValue;
  String? user;
  num? fee;
  String? status;
  String? subscribedOn;
  String? expiredOn;
  int? validity;
  num? tds;
  num? npnl;
  num? payout;
  num? gpnl;
  num? brokerage;
  int? tradingDays;
  int? trades;

  TenxExpiredPlan({
    this.sId,
    this.planName,
    this.expiryDays,
    this.payoutPercentage,
    this.features,
    this.portfolioValue,
    this.user,
    this.fee,
    this.status,
    this.subscribedOn,
    this.expiredOn,
    this.validity,
    this.npnl,
    this.payout,
    this.tds,
    this.gpnl,
    this.brokerage,
    this.tradingDays,
    this.trades,
  });

  TenxExpiredPlan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['plan_name'];
    expiryDays = json['expiryDays'];
    payoutPercentage = json['payoutPercentage'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    portfolioValue = json['portfolioValue'];
    user = json['user'];
    fee = json['fee'];
    status = json['status'];
    gpnl = json['gpnl'];
    brokerage = json['brokerage'];
    trades = json['trades'];
    tradingDays = json['tradingDays'];
    subscribedOn = json['subscribedOn'];
    expiredOn = json['expiredOn'];
    validity = json['validity'];
    npnl = json['npnl'];
    payout = json['payout'];
    tds = json['tdsAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plan_name'] = this.planName;
    data['expiryDays'] = this.expiryDays;
    data['payoutPercentage'] = this.payoutPercentage;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    data['portfolioValue'] = this.portfolioValue;
    data['user'] = this.user;
    data['fee'] = this.fee;
    data['gpnl'] = this.gpnl;
    data['status'] = this.status;
    data['subscribedOn'] = this.subscribedOn;
    data['expiredOn'] = this.expiredOn;
    data['validity'] = this.validity;
    data['tds'] = this.tds;
    data['payout'] = this.payout;
    data['npnl'] = this.npnl;
    data['tradingDays'] = this.tradingDays;
    data['brokerage'] = this.brokerage;
    data['trades'] = this.trades;
    return data;
  }
}
