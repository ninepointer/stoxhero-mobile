class FcmTokenDataRequest {
  FcmTokenData? fcmTokenData;

  FcmTokenDataRequest({
    this.fcmTokenData,
  });

  FcmTokenDataRequest.fromJson(Map<String, dynamic> json) {
    fcmTokenData = json['fcmTokenData'] != null ? new FcmTokenData.fromJson(json['fcmTokenData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fcmTokenData != null) {
      data['fcmTokenData'] = this.fcmTokenData!.toJson();
    }
    return data;
  }
}

class FcmTokenData {
  String? token;
  String? brand;
  String? model;
  String? platform;
  String? osVersion;

  FcmTokenData({
    this.token,
    this.brand,
    this.model,
    this.platform,
    this.osVersion,
  });

  FcmTokenData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    brand = json['brand'];
    model = json['model'];
    platform = json['platform'];
    osVersion = json['osVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['platform'] = this.platform;
    data['osVersion'] = this.osVersion;
    return data;
  }
}
