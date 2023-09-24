class ContestLeaderboardResponse {
  String? status;
  String? message;
  List<ContestLeaderboard>? data;

  ContestLeaderboardResponse({this.status, this.message, this.data});

  ContestLeaderboardResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContestLeaderboard>[];
      json['data'].forEach((v) {
        data!.add(new ContestLeaderboard.fromJson(v));
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

class ContestLeaderboard {
  Id? iId;
  int? contestParticipated;
  int? contestWon;
  num? totalPayout;
  String? traderFirstName;
  String? traderLastName;
  String? traderProfilePhoto;
  num? strikeRate;

  ContestLeaderboard({
    this.iId,
    this.contestParticipated,
    this.contestWon,
    this.totalPayout,
    this.traderFirstName,
    this.traderLastName,
    this.traderProfilePhoto,
    this.strikeRate,
  });

  ContestLeaderboard.fromJson(Map<String, dynamic> json) {
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
    contestParticipated = json['contestParticipated'];
    contestWon = json['contestWon'];
    totalPayout = json['totalPayout'];
    traderFirstName = json['traderFirstName'];
    traderLastName = json['traderLastName'];
    traderProfilePhoto = json['traderProfilePhoto'];
    strikeRate = json['strikeRate'];
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
    data['traderProfilePhoto'] = this.traderProfilePhoto;
    data['strikeRate'] = this.strikeRate;
    return data;
  }
}

class Id {
  String? trader;

  Id({this.trader});

  Id.fromJson(Map<String, dynamic> json) {
    trader = json['trader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trader'] = this.trader;
    return data;
  }
}
