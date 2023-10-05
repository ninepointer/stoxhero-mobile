class LiveContestLeaderboardReponse {
  List<LiveContestLeaderboard>? data;

  LiveContestLeaderboardReponse({this.data});

  LiveContestLeaderboardReponse.fromJson(List? json) {
    if (json != null) {
      data = <LiveContestLeaderboard>[];
      data = json.map((data) => LiveContestLeaderboard.fromJson(data)).toList();
    }
  }
}

class LiveContestLeaderboard {
  String? name;
  double? npnl;
  String? userName;
  String? photo;

  LiveContestLeaderboard({this.name, this.npnl, this.userName, this.photo});

  LiveContestLeaderboard.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    npnl = json['npnl'];
    userName = json['userName'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['npnl'] = this.npnl;
    data['userName'] = this.userName;
    data['photo'] = this.photo;
    return data;
  }
}
