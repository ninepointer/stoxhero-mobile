class TenxMyActiveSubscribedListResponse {
  String? status;
  List<TenxMyActiveSubscribedList>? data;

  TenxMyActiveSubscribedListResponse({this.status, this.data});

  TenxMyActiveSubscribedListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxMyActiveSubscribedList>[];
      json['data'].forEach((v) {
        data!.add(new TenxMyActiveSubscribedList.fromJson(v));
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

class TenxMyActiveSubscribedList {
  String? sId;
  String? planName;
  int? discountedPrice;
  int? expiryDays;
  int? payoutPercentage;
  List<Features>? features;
  bool? allowRenewal;
  int? portfolioValue;
  String? user;
  int? fee;
  String? status;
  String? subscribedOn;

  TenxMyActiveSubscribedList(
      {this.sId,
      this.planName,
      this.discountedPrice,
      this.expiryDays,
      this.payoutPercentage,
      this.features,
      this.allowRenewal,
      this.portfolioValue,
      this.user,
      this.fee,
      this.status,
      this.subscribedOn});

  TenxMyActiveSubscribedList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['plan_name'];
    discountedPrice = json['discounted_price'];
    expiryDays = json['expiryDays'];
    payoutPercentage = json['payoutPercentage'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    allowRenewal = json['allowRenewal'];
    portfolioValue = json['portfolioValue'];
    user = json['user'];
    fee = json['fee'];
    status = json['status'];
    subscribedOn = json['subscribedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plan_name'] = this.planName;
    data['discounted_price'] = this.discountedPrice;
    data['expiryDays'] = this.expiryDays;
    data['payoutPercentage'] = this.payoutPercentage;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    data['allowRenewal'] = this.allowRenewal;
    data['portfolioValue'] = this.portfolioValue;
    data['user'] = this.user;
    data['fee'] = this.fee;
    data['status'] = this.status;
    data['subscribedOn'] = this.subscribedOn;
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
