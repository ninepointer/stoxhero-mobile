class CampaignCodeResponse {
  String? status;
  String? message;
  CampaignCodeData? data;

  CampaignCodeResponse({this.status, this.message, this.data});

  CampaignCodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new CampaignCodeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CampaignCodeData {
  String? campaignCode;
  CampaignSignupBonus? campaignSignupBonus;

  CampaignCodeData({this.campaignCode, this.campaignSignupBonus});

  CampaignCodeData.fromJson(Map<String, dynamic> json) {
    campaignCode = json['campaignCode'];
    campaignSignupBonus =
        json['campaignSignupBonus'] != null ? new CampaignSignupBonus.fromJson(json['campaignSignupBonus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['campaignCode'] = this.campaignCode;
    if (this.campaignSignupBonus != null) {
      data['campaignSignupBonus'] = this.campaignSignupBonus!.toJson();
    }
    return data;
  }
}

class CampaignSignupBonus {
  num? amount;
  String? currency;

  CampaignSignupBonus({this.amount, this.currency});

  CampaignSignupBonus.fromJson(Map<String, dynamic> json) {
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
