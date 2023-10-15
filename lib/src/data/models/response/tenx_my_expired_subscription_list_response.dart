class TenxMyExpiredSubscriptionListResponse {
  String? status;
  List<TenxMyExpiredSubscriptionList>? data;

  TenxMyExpiredSubscriptionListResponse({this.status, this.data});

  TenxMyExpiredSubscriptionListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxMyExpiredSubscriptionList>[];
      json['data'].forEach((v) {
        data!.add(new TenxMyExpiredSubscriptionList.fromJson(v));
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

class TenxMyExpiredSubscriptionList {
  String? sId;
  String? planName;
  int? expiryDays;
  int? payoutPercentage;
  List<Features>? features;
  int? portfolioValue;
  String? user;
  int? fee;
  String? status;
  String? subscribedOn;
  String? expiredOn;

  TenxMyExpiredSubscriptionList(
      {this.sId,
      this.planName,
      this.expiryDays,
      this.payoutPercentage,
      this.features,
      this.portfolioValue,
      this.user,
      this.fee,
      this.status,
      this.subscribedOn,
      this.expiredOn});

  TenxMyExpiredSubscriptionList.fromJson(Map<String, dynamic> json) {
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
    subscribedOn = json['subscribedOn'];
    expiredOn = json['expiredOn'];
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
    data['status'] = this.status;
    data['subscribedOn'] = this.subscribedOn;
    data['expiredOn'] = this.expiredOn;
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
