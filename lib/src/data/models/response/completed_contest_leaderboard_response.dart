class CompletedContestLeaderboardListResponse {
  String? status;
  String? message;
  List<CompletedContestLeaderboardList>? data;

  CompletedContestLeaderboardListResponse({this.status, this.message, this.data});

  CompletedContestLeaderboardListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompletedContestLeaderboardList>[];
      json['data'].forEach((v) {
        data!.add(new CompletedContestLeaderboardList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedContestLeaderboardList {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;
  dynamic rank;
  num? payout;

  CompletedContestLeaderboardList({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.rank,
    this.payout,
  });

  CompletedContestLeaderboardList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    rank = json['rank'];
    payout = json['payout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userId'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['rank'] = this.rank;
    data['payout'] = this.payout;
    return data;
  }
}
