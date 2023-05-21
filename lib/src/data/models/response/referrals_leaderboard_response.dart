class ReferralsLeaderboardResponse {
  String? status;
  int? results;
  List<LeaderboardUserDetails>? data;

  ReferralsLeaderboardResponse({
    this.status,
    this.results,
    this.data,
  });

  ReferralsLeaderboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      data = <LeaderboardUserDetails>[];
      json['data'].forEach((v) {
        data!.add(new LeaderboardUserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['results'] = this.results;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaderboardUserDetails {
  String? user;
  String? firstName;
  String? lastName;
  String? referralCount;
  num? earnings;

  LeaderboardUserDetails({
    this.user,
    this.firstName,
    this.lastName,
    this.referralCount,
    this.earnings,
  });

  LeaderboardUserDetails.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    referralCount = json['referralCount'];
    earnings = json['earnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['referralCount'] = this.referralCount;
    data['earnings'] = this.earnings;
    return data;
  }
}
