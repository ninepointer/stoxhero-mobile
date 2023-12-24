class AffiliateRefferralsResponse {
  String? status;
  AffiliateRefferalsSignupData? data;

  AffiliateRefferralsResponse({this.status, this.data});

  AffiliateRefferralsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new AffiliateRefferalsSignupData.fromJson(json['data'])
        : null;
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

class AffiliateRefferalsSignupData {
  String? sId;
  List<AffiliateReferrals>? affiliateReferrals;

  AffiliateRefferalsSignupData({this.sId, this.affiliateReferrals});

  AffiliateRefferalsSignupData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['affiliateReferrals'] != null) {
      affiliateReferrals = <AffiliateReferrals>[];
      json['affiliateReferrals'].forEach((v) {
        affiliateReferrals!.add(new AffiliateReferrals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.affiliateReferrals != null) {
      data['affiliateReferrals'] =
          this.affiliateReferrals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AffiliateReferrals {
  ReferredUserId? referredUserId;
  String? affiliateProgram;
  String? affiliateCurrency;
  String? sId;
  int? affiliateEarning;

  AffiliateReferrals(
      {this.referredUserId,
      this.affiliateProgram,
      this.affiliateCurrency,
      this.sId,
      this.affiliateEarning});

  AffiliateReferrals.fromJson(Map<String, dynamic> json) {
    referredUserId = json['referredUserId'] != null
        ? new ReferredUserId.fromJson(json['referredUserId'])
        : null;
    affiliateProgram = json['affiliateProgram'];
    affiliateCurrency = json['affiliateCurrency'];
    sId = json['_id'];
    affiliateEarning = json['affiliateEarning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referredUserId != null) {
      data['referredUserId'] = this.referredUserId!.toJson();
    }
    data['affiliateProgram'] = this.affiliateProgram;
    data['affiliateCurrency'] = this.affiliateCurrency;
    data['_id'] = this.sId;
    data['affiliateEarning'] = this.affiliateEarning;
    return data;
  }
}

class ReferredUserId {
  String? sId;
  String? firstName;
  String? lastName;
  String? joiningDate;

  ReferredUserId({this.sId, this.firstName, this.lastName, this.joiningDate});

  ReferredUserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    joiningDate = json['joining_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['joining_date'] = this.joiningDate;
    return data;
  }
}
