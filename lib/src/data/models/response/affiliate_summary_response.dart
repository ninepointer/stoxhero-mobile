class AffiliateSummaryResponse {
  String? status;
  List<AffiliateSummaryData>? data;
  List<AffiliateRafferalSummeryData>? affiliateRafferalSummery;
  String? message;

  AffiliateSummaryResponse(
      {this.status, this.data, this.affiliateRafferalSummery, this.message});

  AffiliateSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AffiliateSummaryData>[];
      json['data'].forEach((v) {
        data!.add(new AffiliateSummaryData.fromJson(v));
      });
    }
    if (json['affiliateRafferalSummery'] != null) {
      affiliateRafferalSummery = <AffiliateRafferalSummeryData>[];
      json['affiliateRafferalSummery'].forEach((v) {
        affiliateRafferalSummery!
            .add(new AffiliateRafferalSummeryData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.affiliateRafferalSummery != null) {
      data['affiliateRafferalSummery'] =
          this.affiliateRafferalSummery!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class AffiliateSummaryData {
  List<AffiliateSummaryDetails>? summery;

  AffiliateSummaryData({this.summery});

  AffiliateSummaryData.fromJson(Map<String, dynamic> json) {
    if (json['summery'] != null) {
      summery = <AffiliateSummaryDetails>[];
      json['summery'].forEach((v) {
        summery!.add(new AffiliateSummaryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summery != null) {
      data['summery'] = this.summery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AffiliateSummaryDetails {
  num? totalProductCount;
  num? totalProductCPayout;

  AffiliateSummaryDetails({this.totalProductCount, this.totalProductCPayout});

  AffiliateSummaryDetails.fromJson(Map<String, dynamic> json) {
    totalProductCount = json['totalProductCount'];
    totalProductCPayout = json['totalProductCPayout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProductCount'] = this.totalProductCount;
    data['totalProductCPayout'] = this.totalProductCPayout;
    return data;
  }
}

class AffiliateRafferalSummeryData {
  int? affiliateRefferalCount;
  int? activeAffiliateRefferalCount;
  int? paidAffiliateRefferalCount;
  int? affiliateRefferalPayout;

  AffiliateRafferalSummeryData(
      {this.affiliateRefferalCount,
      this.activeAffiliateRefferalCount,
      this.paidAffiliateRefferalCount,
      this.affiliateRefferalPayout});

  AffiliateRafferalSummeryData.fromJson(Map<String, dynamic> json) {
    affiliateRefferalCount = json['affiliateRefferalCount'];
    activeAffiliateRefferalCount = json['activeAffiliateRefferalCount'];
    paidAffiliateRefferalCount = json['paidAffiliateRefferalCount'];
    affiliateRefferalPayout = json['affiliateRefferalPayout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['affiliateRefferalCount'] = this.affiliateRefferalCount;
    data['activeAffiliateRefferalCount'] = this.activeAffiliateRefferalCount;
    data['paidAffiliateRefferalCount'] = this.paidAffiliateRefferalCount;
    data['affiliateRefferalPayout'] = this.affiliateRefferalPayout;
    return data;
  }
}
