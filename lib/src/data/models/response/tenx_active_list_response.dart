import '../models.dart';

class TenxActivePlanListResponse {
  String? status;
  List<TenxActivePlan>? data;

  TenxActivePlanListResponse({this.status, this.data});

  TenxActivePlanListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxActivePlan>[];
      json['data'].forEach((v) {
        data!.add(new TenxActivePlan.fromJson(v));
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

class TenxActivePlan {
  String? sId;
  String? planName;
  num? actualPrice;
  num? discountedPrice;
  int? validity;
  int? expiryDays;
  num? payoutPercentage;
  num? profitCap;
  CollegePortfolio? portfolio;
  String? validityPeriod;
  List<Features>? features;
  String? status;
  bool? allowPurchase;
  bool? allowRenewal;

  TenxActivePlan(
      {this.sId,
      this.planName,
      this.actualPrice,
      this.discountedPrice,
      this.validity,
      this.expiryDays,
      this.payoutPercentage,
      this.profitCap,
      this.portfolio,
      this.validityPeriod,
      this.features,
      this.status,
      this.allowPurchase,
      this.allowRenewal});

  TenxActivePlan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['plan_name'];
    actualPrice = json['actual_price'];
    discountedPrice = json['discounted_price'];
    validity = json['validity'];
    expiryDays = json['expiryDays'];
    payoutPercentage = json['payoutPercentage'];
    profitCap = json['profitCap'];
    portfolio = json['portfolio'] != null ? new CollegePortfolio.fromJson(json['portfolio']) : null;
    validityPeriod = json['validityPeriod'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    status = json['status'];
    allowPurchase = json['allowPurchase'];
    allowRenewal = json['allowRenewal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plan_name'] = this.planName;
    data['actual_price'] = this.actualPrice;
    data['discounted_price'] = this.discountedPrice;
    data['validity'] = this.validity;
    data['expiryDays'] = this.expiryDays;
    data['payoutPercentage'] = this.payoutPercentage;
    data['profitCap'] = this.profitCap;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    data['validityPeriod'] = this.validityPeriod;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['allowPurchase'] = this.allowPurchase;
    data['allowRenewal'] = this.allowRenewal;
    return data;
  }
}

class Features {
  int? orderNo;
  String? description;
  String? sId;

  Features({this.orderNo, this.description, this.sId});

  Features.fromJson(Map<String, dynamic> json) {
    orderNo = json['orderNo'];
    description = json['description'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNo'] = this.orderNo;
    data['description'] = this.description;
    data['_id'] = this.sId;
    return data;
  }
}
