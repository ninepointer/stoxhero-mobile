class TenxLeaderboardListResponse {
  String? status;
  List<TenxLeaderboardList>? data;

  TenxLeaderboardListResponse({this.status, this.data});

  TenxLeaderboardListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxLeaderboardList>[];
      json['data'].forEach((v) {
        data!.add(new TenxLeaderboardList.fromJson(v));
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

class TenxLeaderboardList {
  String? sId;
  String? firstName;
  String? lastName;
  String? userid;
  String? status;
  num? earnings;
  int? subscriptions;
  num? subscriptionsWithPayout;
  num? strikeRate;
  String? profilePic;

  TenxLeaderboardList({
    this.sId,
    this.firstName,
    this.lastName,
    this.userid,
    this.status,
    this.earnings,
    this.subscriptions,
    this.subscriptionsWithPayout,
    this.strikeRate,
    this.profilePic,
  });

  TenxLeaderboardList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userid = json['userid'];
    status = json['status'];
    earnings = json['earnings'];
    subscriptions = json['subscriptions'];
    subscriptionsWithPayout = json['subscriptionsWithPayout'];
    strikeRate = json['strikeRate'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['userid'] = this.userid;
    data['status'] = this.status;
    data['earnings'] = this.earnings;
    data['subscriptions'] = this.subscriptions;
    data['subscriptionsWithPayout'] = this.subscriptionsWithPayout;
    data['strikeRate'] = this.strikeRate;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
