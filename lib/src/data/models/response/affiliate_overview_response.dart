class AffiliateOverViewResponse {
  String? status;
  AffiliateOverviewData? data;

  AffiliateOverViewResponse({this.status, this.data});

  AffiliateOverViewResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new AffiliateOverviewData.fromJson(json['data'])
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

class AffiliateOverviewData {
  int? rewardPerReferral;
  num? commissionPercentage;
  String? userName;
  MyImage? image;
  num? lifetimeEarning;
  int? affiliateRefferalCount;
  int? activeAffiliateRefferalCount;
  int? paidAffiliateRefferalCount;
  int? paidActiveAffiliateRefferalCount;
  num? affiliateRefferalPayout;

  AffiliateOverviewData({
    this.rewardPerReferral,
    this.commissionPercentage,
    this.userName,
    this.image,
    this.lifetimeEarning,
    this.affiliateRefferalCount,
    this.activeAffiliateRefferalCount,
    this.paidAffiliateRefferalCount,
    this.paidActiveAffiliateRefferalCount,
    this.affiliateRefferalPayout,
  });

  AffiliateOverviewData.fromJson(Map<String, dynamic> json) {
    rewardPerReferral = json['rewardPerReferral'];
    commissionPercentage = json['commissionPercentage'];
    userName = json['userName'];
    image = json['image'] != null ? new MyImage.fromJson(json['image']) : null;
    lifetimeEarning = json['lifetimeEarning'];
    affiliateRefferalCount = json['affiliateRefferalCount'];
    activeAffiliateRefferalCount = json['activeAffiliateRefferalCount'];
    paidAffiliateRefferalCount = json['paidAffiliateRefferalCount'];
    paidActiveAffiliateRefferalCount = json['paidActiveAffiliateRefferalCount'];
    affiliateRefferalPayout = json['affiliateRefferalPayout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rewardPerReferral'] = this.rewardPerReferral;
    data['commissionPercentage'] = this.commissionPercentage;
    data['userName'] = this.userName;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['lifetimeEarning'] = this.lifetimeEarning;
    data['affiliateRefferalCount'] = this.affiliateRefferalCount;
    data['activeAffiliateRefferalCount'] = this.activeAffiliateRefferalCount;
    data['paidAffiliateRefferalCount'] = this.paidAffiliateRefferalCount;
    data['paidActiveAffiliateRefferalCount'] =
        this.paidActiveAffiliateRefferalCount;
    data['affiliateRefferalPayout'] = this.affiliateRefferalPayout;
    return data;
  }
}

class MyImage {
  String? url;
  String? name;

  MyImage({this.url, this.name});

  MyImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}
