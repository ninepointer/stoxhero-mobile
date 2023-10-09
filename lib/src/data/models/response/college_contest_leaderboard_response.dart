class CollegeContestLeaderboardResponse {
  String? status;
  String? message;
  List<CollegeContestLeaderboard>? data;

  CollegeContestLeaderboardResponse({this.status, this.message, this.data});

  CollegeContestLeaderboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CollegeContestLeaderboard>[];
      json['data'].forEach((v) {
        data!.add(new CollegeContestLeaderboard.fromJson(v));
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

class CollegeContestLeaderboard {
  CollegeId? iId;
  int? contestParticipated;
  int? contestWon;
  num? totalPayout;
  String? traderFirstName;
  String? traderLastName;
  num? strikeRate;
  String? traderProfilePhoto;

  CollegeContestLeaderboard(
      {this.iId,
      this.contestParticipated,
      this.contestWon,
      this.totalPayout,
      this.traderFirstName,
      this.traderLastName,
      this.strikeRate,
      this.traderProfilePhoto});

  CollegeContestLeaderboard.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new CollegeId.fromJson(json['_id']) : null;
    contestParticipated = json['contestParticipated'];
    contestWon = json['contestWon'];
    totalPayout = json['totalPayout'];
    traderFirstName = json['traderFirstName'];
    traderLastName = json['traderLastName'];
    strikeRate = json['strikeRate'];
    traderProfilePhoto = json['traderProfilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    data['contestParticipated'] = this.contestParticipated;
    data['contestWon'] = this.contestWon;
    data['totalPayout'] = this.totalPayout;
    data['traderFirstName'] = this.traderFirstName;
    data['traderLastName'] = this.traderLastName;
    data['strikeRate'] = this.strikeRate;
    data['traderProfilePhoto'] = this.traderProfilePhoto;
    return data;
  }
}

class CollegeId {
  String? trader;

  CollegeId({this.trader});

  CollegeId.fromJson(Map<String, dynamic> json) {
    trader = json['trader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trader'] = this.trader;
    return data;
  }
}
