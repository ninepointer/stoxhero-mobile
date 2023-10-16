import '../models.dart';

class TenxTradingActiveResponse {
  String? status;
  List<TenxActiveSubscription>? data;
  int? results;

  TenxTradingActiveResponse({this.status, this.data, this.results});

  TenxTradingActiveResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxActiveSubscription>[];
      json['data'].forEach((v) {
        data!.add(new TenxActiveSubscription.fromJson(v));
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

class TenxActiveSubscription {
  String? sId;
  String? planName;
  num? actualPrice;
  num? discountedPrice;
  num? validity;
  num? profitCap;
  Portfolio? portfolio;
  String? validityPeriod;
  List<Features>? features;
  String? status;
  String? createdOn;
  String? createdBy;
  String? lastModifiedOn;
  String? lastModifiedBy;

  TenxActiveSubscription({
    this.sId,
    this.planName,
    this.actualPrice,
    this.discountedPrice,
    this.validity,
    this.profitCap,
    this.portfolio,
    this.validityPeriod,
    this.features,
    this.status,
    this.createdOn,
    this.createdBy,
    this.lastModifiedOn,
    this.lastModifiedBy,
  });

  TenxActiveSubscription.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['plan_name'];
    actualPrice = json['actual_price'];
    discountedPrice = json['discounted_price'];
    validity = json['validity'];
    profitCap = json['profitCap'];
    portfolio = json['portfolio'] != null ? new Portfolio.fromJson(json['portfolio']) : null;
    validityPeriod = json['validityPeriod'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    status = json['status'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    lastModifiedOn = json['lastModifiedOn'];
    lastModifiedBy = json['lastModifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plan_name'] = this.planName;
    data['actual_price'] = this.actualPrice;
    data['discounted_price'] = this.discountedPrice;
    data['validity'] = this.validity;
    data['profitCap'] = this.profitCap;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    data['validityPeriod'] = this.validityPeriod;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['lastModifiedBy'] = this.lastModifiedBy;
    return data;
  }
}

class Features {
  int? orderNo;
  String? description;
  String? sId;

  Features({
    this.orderNo,
    this.description,
    this.sId,
  });

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
