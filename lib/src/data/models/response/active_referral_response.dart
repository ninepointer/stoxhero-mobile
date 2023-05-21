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

class ActiveReferral {
  String? sId;
  String? referralProgramName;
  int? rewardPerReferral;
  String? currency;
  String? description;
  String? referrralProgramId;

  ActiveReferral({
    this.sId,
    this.referralProgramName,
    this.rewardPerReferral,
    this.currency,
    this.description,
    this.referrralProgramId,
  });

  ActiveReferral.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    referralProgramName = json['referralProgramName'];
    rewardPerReferral = json['rewardPerReferral'];
    currency = json['currency'];
    description = json['description'];
    referrralProgramId = json['referrralProgramId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['referralProgramName'] = this.referralProgramName;
    data['rewardPerReferral'] = this.rewardPerReferral;
    data['currency'] = this.currency;
    data['description'] = this.description;
    data['referrralProgramId'] = this.referrralProgramId;
    return data;
  }
}
