import 'package:stoxhero/src/app/app.dart';

class VerifySigninRequest {
  String? mobile;
  String? mobileOtp;
  FcmTokenData? fcmTokenData;

  VerifySigninRequest({
    this.mobile,
    this.mobileOtp,
    this.fcmTokenData,
  });

  VerifySigninRequest.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    mobileOtp = json['mobile_otp'];
    fcmTokenData = json['fcmTokenData'] != null ? new FcmTokenData.fromJson(json['fcmTokenData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['mobile_otp'] = this.mobileOtp;
    if (this.fcmTokenData != null) {
      data['fcmTokenData'] = this.fcmTokenData!.toJson();
    }
    return data;
  }
}
