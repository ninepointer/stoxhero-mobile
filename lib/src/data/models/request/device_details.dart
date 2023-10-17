class DeviceDetails {
  String? deviceType;
  String? platformType;

  DeviceDetails({
    this.deviceType,
    this.platformType,
  });

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    platformType = json['platformType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceType'] = this.deviceType;
    data['platformType'] = this.platformType;
    return data;
  }
}
