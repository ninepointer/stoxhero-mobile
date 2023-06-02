class AnalyticsOverviewDetailsResponse {
  String? status;
  List<AnalyticsOverviewDetails>? data;

  AnalyticsOverviewDetailsResponse({
    this.status,
    this.data,
  });

  AnalyticsOverviewDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AnalyticsOverviewDetails>[];
      json['data'].forEach((v) {
        data!.add(new AnalyticsOverviewDetails.fromJson(v));
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

class AnalyticsOverviewDetails {
  num? grossPNLDaily;
  num? brokerageSumDaily;
  num? grossPNLMonthly;
  num? brokerageSumMonthly;
  num? grossPNLYearly;
  num? brokerageSumYearly;
  num? grossPNLLifetime;
  num? brokerageSumLifetime;
  num? netPNLDaily;
  num? netPNLMonthly;
  num? netPNLYearly;
  num? netPNLLifetime;

  AnalyticsOverviewDetails({
    this.grossPNLDaily,
    this.brokerageSumDaily,
    this.grossPNLMonthly,
    this.brokerageSumMonthly,
    this.grossPNLYearly,
    this.brokerageSumYearly,
    this.grossPNLLifetime,
    this.brokerageSumLifetime,
    this.netPNLDaily,
    this.netPNLMonthly,
    this.netPNLYearly,
    this.netPNLLifetime,
  });

  AnalyticsOverviewDetails.fromJson(Map<String, dynamic> json) {
    grossPNLDaily = json['grossPNLDaily'];
    brokerageSumDaily = json['brokerageSumDaily'];
    grossPNLMonthly = json['grossPNLMonthly'];
    brokerageSumMonthly = json['brokerageSumMonthly'];
    grossPNLYearly = json['grossPNLYearly'];
    brokerageSumYearly = json['brokerageSumYearly'];
    grossPNLLifetime = json['grossPNLLifetime'];
    brokerageSumLifetime = json['brokerageSumLifetime'];
    netPNLDaily = json['netPNLDaily'];
    netPNLMonthly = json['netPNLMonthly'];
    netPNLYearly = json['netPNLYearly'];
    netPNLLifetime = json['netPNLLifetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grossPNLDaily'] = this.grossPNLDaily;
    data['brokerageSumDaily'] = this.brokerageSumDaily;
    data['grossPNLMonthly'] = this.grossPNLMonthly;
    data['brokerageSumMonthly'] = this.brokerageSumMonthly;
    data['grossPNLYearly'] = this.grossPNLYearly;
    data['brokerageSumYearly'] = this.brokerageSumYearly;
    data['grossPNLLifetime'] = this.grossPNLLifetime;
    data['brokerageSumLifetime'] = this.brokerageSumLifetime;
    data['netPNLDaily'] = this.netPNLDaily;
    data['netPNLMonthly'] = this.netPNLMonthly;
    data['netPNLYearly'] = this.netPNLYearly;
    data['netPNLLifetime'] = this.netPNLLifetime;
    return data;
  }
}
