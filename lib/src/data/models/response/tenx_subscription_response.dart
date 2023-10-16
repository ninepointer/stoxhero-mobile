class TenXSubscriptionResponse {
  String? message;
  List<TenXSubscription>? data;

  TenXSubscriptionResponse({this.message, this.data});

  TenXSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TenXSubscription>[];
      json['data'].forEach((v) {
        data!.add(new TenXSubscription.fromJson(v));
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

class TenXSubscription {
  String? subscriptionName;
  String? subscriptionId;
  List<UserPurchaseDetail>? userPurchaseDetail;

  TenXSubscription({this.subscriptionName, this.subscriptionId, this.userPurchaseDetail});

  TenXSubscription.fromJson(Map<String, dynamic> json) {
    subscriptionName = json['subscriptionName'];
    subscriptionId = json['subscriptionId'];
    if (json['userPurchaseDetail'] != null) {
      userPurchaseDetail = <UserPurchaseDetail>[];
      json['userPurchaseDetail'].forEach((v) {
        userPurchaseDetail!.add(new UserPurchaseDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionName'] = this.subscriptionName;
    data['subscriptionId'] = this.subscriptionId;
    if (this.userPurchaseDetail != null) {
      data['userPurchaseDetail'] = this.userPurchaseDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPurchaseDetail {
  String? userId;
  String? subscribedOn;
  String? status;
  String? sId;
  String? expiredOn;
  num? fee;
  num? payout;
  String? expiredBy;

  UserPurchaseDetail(
      {this.userId, this.subscribedOn, this.status, this.sId, this.expiredOn, this.fee, this.payout, this.expiredBy});

  UserPurchaseDetail.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    subscribedOn = json['subscribedOn'];
    status = json['status'];
    sId = json['_id'];
    expiredOn = json['expiredOn'];
    fee = json['fee'];
    payout = json['payout'];
    expiredBy = json['expiredBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['subscribedOn'] = this.subscribedOn;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['expiredOn'] = this.expiredOn;
    data['fee'] = this.fee;
    data['payout'] = this.payout;
    data['expiredBy'] = this.expiredBy;
    return data;
  }
}
