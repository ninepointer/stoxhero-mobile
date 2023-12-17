class ReadSettingResponse {
  Toggle? toggle;
  Contest? contest;
  Time? time;
  String? sId;
  String? appEndTime;
  String? appStartTime;
  num? iV;
  bool? infinityLive;
  num? infinityPrice;
  bool? isAppLive;
  num? leaderBoardTimming;
  num? maxWithdrawal;
  num? minWithdrawal;
  String? modifiedBy;
  String? modifiedOn;
  bool? timer;
  num? maxWithdrawalHigh;
  num? walletBalanceUpperLimit;
  num? gstPercentage;
  num? tdsPercentage;
  String? mobileAppVersion;
  num? bonusToUnitCashRatio;
  num? maxBonusRedemptionPercentage;
  num? minWalletBalance;

  ReadSettingResponse(
      {this.toggle,
      this.contest,
      this.time,
      this.sId,
      this.appEndTime,
      this.appStartTime,
      this.iV,
      this.infinityLive,
      this.infinityPrice,
      this.isAppLive,
      this.leaderBoardTimming,
      this.maxWithdrawal,
      this.minWithdrawal,
      this.modifiedBy,
      this.modifiedOn,
      this.timer,
      this.maxWithdrawalHigh,
      this.walletBalanceUpperLimit,
      this.gstPercentage,
      this.tdsPercentage,
      this.mobileAppVersion,
      this.bonusToUnitCashRatio,
      this.maxBonusRedemptionPercentage,
      this.minWalletBalance});

  ReadSettingResponse.fromJson(Map<String, dynamic> json) {
    toggle =
        json['toggle'] != null ? new Toggle.fromJson(json['toggle']) : null;
    contest =
        json['contest'] != null ? new Contest.fromJson(json['contest']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    sId = json['_id'];
    appEndTime = json['AppEndTime'];
    appStartTime = json['AppStartTime'];
    iV = json['__v'];
    infinityLive = json['infinityLive'];
    infinityPrice = json['infinityPrice'];
    isAppLive = json['isAppLive'];
    leaderBoardTimming = json['leaderBoardTimming'];
    maxWithdrawal = json['maxWithdrawal'];
    minWithdrawal = json['minWithdrawal'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
    timer = json['timer'];
    maxWithdrawalHigh = json['maxWithdrawalHigh'];
    walletBalanceUpperLimit = json['walletBalanceUpperLimit'];
    gstPercentage = json['gstPercentage'];
    tdsPercentage = json['tdsPercentage'];
    mobileAppVersion = json['mobileAppVersion'];
    bonusToUnitCashRatio = json['bonusToUnitCashRatio'];
    maxBonusRedemptionPercentage = json['maxBonusRedemptionPercentage'];
    minWalletBalance = json['minWalletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.toggle != null) {
      data['toggle'] = this.toggle!.toJson();
    }
    if (this.contest != null) {
      data['contest'] = this.contest!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    data['_id'] = this.sId;
    data['AppEndTime'] = this.appEndTime;
    data['AppStartTime'] = this.appStartTime;
    data['__v'] = this.iV;
    data['infinityLive'] = this.infinityLive;
    data['infinityPrice'] = this.infinityPrice;
    data['isAppLive'] = this.isAppLive;
    data['leaderBoardTimming'] = this.leaderBoardTimming;
    data['maxWithdrawal'] = this.maxWithdrawal;
    data['minWithdrawal'] = this.minWithdrawal;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    data['timer'] = this.timer;
    data['maxWithdrawalHigh'] = this.maxWithdrawalHigh;
    data['walletBalanceUpperLimit'] = this.walletBalanceUpperLimit;
    data['gstPercentage'] = this.gstPercentage;
    data['tdsPercentage'] = this.tdsPercentage;
    data['mobileAppVersion'] = this.mobileAppVersion;
    data['bonusToUnitCashRatio'] = this.bonusToUnitCashRatio;
    data['maxBonusRedemptionPercentage'] = this.maxBonusRedemptionPercentage;
    data['minWalletBalance'] = this.minWalletBalance;
    return data;
  }
}

class Toggle {
  String? complete;
  String? ltp;
  String? liveOrder;

  Toggle({this.complete, this.ltp, this.liveOrder});

  Toggle.fromJson(Map<String, dynamic> json) {
    complete = json['complete'];
    ltp = json['ltp'];
    liveOrder = json['liveOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complete'] = this.complete;
    data['ltp'] = this.ltp;
    data['liveOrder'] = this.liveOrder;
    return data;
  }
}

class Contest {
  String? email;
  String? mobile;
  String? upiId;

  Contest({this.email, this.mobile, this.upiId});

  Contest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
    upiId = json['upiId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['upiId'] = this.upiId;
    return data;
  }
}

class Time {
  String? appStartTime;
  String? appEndTime;
  String? timerStartTimeInEnd;
  String? timerStartTimeInStart;
  String? message;

  Time({
    this.appStartTime,
    this.appEndTime,
    this.timerStartTimeInEnd,
    this.timerStartTimeInStart,
    this.message,
  });

  Time.fromJson(Map<String, dynamic> json) {
    appStartTime = json['appStartTime'];
    appEndTime = json['appEndTime'];
    timerStartTimeInEnd = json['timerStartTimeInEnd'];
    timerStartTimeInStart = json['timerStartTimeInStart'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appStartTime'] = this.appStartTime;
    data['appEndTime'] = this.appEndTime;
    data['timerStartTimeInEnd'] = this.timerStartTimeInEnd;
    data['timerStartTimeInStart'] = this.timerStartTimeInStart;
    data['message'] = this.message;
    return data;
  }
}
