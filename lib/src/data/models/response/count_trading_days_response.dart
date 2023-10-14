class CountTradingDaysResponse {
  String? status;
  List<CountTradingDays>? data;

  CountTradingDaysResponse({this.status, this.data});

  CountTradingDaysResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CountTradingDays>[];
      json['data'].forEach((v) {
        data!.add(new CountTradingDays.fromJson(v));
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

class CountTradingDays {
  String? subscriptionId;
  int? totalTradingDays;
  int? actualRemainingDay;

  CountTradingDays({this.subscriptionId, this.totalTradingDays, this.actualRemainingDay});

  CountTradingDays.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscriptionId'];
    totalTradingDays = json['totalTradingDays'];
    actualRemainingDay = json['actualRemainingDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscriptionId'] = this.subscriptionId;
    data['totalTradingDays'] = this.totalTradingDays;
    data['actualRemainingDay'] = this.actualRemainingDay;
    return data;
  }
}
