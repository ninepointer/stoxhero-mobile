class TenxTutorialRequest {
  String? message;
  TenxTutorial? data;

  TenxTutorialRequest({this.message, this.data});

  TenxTutorialRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new TenxTutorial.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TenxTutorial {
  String? tutorialViewedBy;
  String? tenXSubscription;
  String? sId;
  String? clickedOn;
  int? iV;

  TenxTutorial({this.tutorialViewedBy, this.tenXSubscription, this.sId, this.clickedOn, this.iV});

  TenxTutorial.fromJson(Map<String, dynamic> json) {
    tutorialViewedBy = json['tutorialViewedBy'];
    tenXSubscription = json['tenXSubscription'];
    sId = json['_id'];
    clickedOn = json['clicked_On'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tutorialViewedBy'] = this.tutorialViewedBy;
    data['tenXSubscription'] = this.tenXSubscription;
    data['_id'] = this.sId;
    data['clicked_On'] = this.clickedOn;
    data['__v'] = this.iV;
    return data;
  }
}
