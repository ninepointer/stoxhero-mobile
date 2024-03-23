class ActiveReferralResponse {
  String? message;
  List<ActiveReferral>? data;

  ActiveReferralResponse({
    this.message,
    this.data,
  });

  ActiveReferralResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ActiveReferral>[];
      json['data'].forEach((v) {
        data!.add(new ActiveReferral.fromJson(v));
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

class refrralSignupBonus {
  num? amount;
  String? currency;

  refrralSignupBonus({
    this.amount,
    this.currency,
  });

  refrralSignupBonus.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;

    return data;
  }
}

class ActiveReferral {
  String? sId;
  String? referralProgramName;
  num? rewardPerReferral;
  String? currency;
  String? description;
  String? referrralProgramId;
  refrralSignupBonus? referralSignupBonus;
  num? maxReferralsPayoutCap;

  ActiveReferral({
    this.sId,
    this.referralProgramName,
    this.referralSignupBonus,
    this.rewardPerReferral,
    this.currency,
    this.description,
    this.referrralProgramId,
    this.maxReferralsPayoutCap
  });

  ActiveReferral.fromJson(Map<String, dynamic> json) {
    referralSignupBonus = json['referralSignupBonus'] != null
        ? new refrralSignupBonus.fromJson(json['referralSignupBonus'])
        : null;
    sId = json['_id'];
    referralProgramName = json['referralProgramName'];
    rewardPerReferral = json['rewardPerReferral'];
    currency = json['currency'];
    description = json['description'];
    referrralProgramId = json['referrralProgramId'];
    maxReferralsPayoutCap = json['maxReferralsPayoutCap'];
    // referralSignupBonus = json['referralSignupBonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referralSignupBonus != null) {
      data['referralSignupBonus'] = this.referralSignupBonus!.toJson();
    }
    data['_id'] = this.sId;
    data['referralProgramName'] = this.referralProgramName;
    data['rewardPerReferral'] = this.rewardPerReferral;
    data['currency'] = this.currency;
    data['description'] = this.description;
    data['referrralProgramId'] = this.referrralProgramId;
    data['maxReferralsPayoutCap'] = this.maxReferralsPayoutCap;
    // data['referralSignupBonus'] = this.referralSignupBonus;
    return data;
  }
}
