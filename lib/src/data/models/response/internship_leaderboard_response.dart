class InternshipLeaderBoardResponse {
  String? message;
  List<InternshipLeaderBoard>? data;

  InternshipLeaderBoardResponse({this.message, this.data});

  InternshipLeaderBoardResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <InternshipLeaderBoard>[];
      json['data'].forEach((v) {
        data!.add(new InternshipLeaderBoard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InternshipLeaderBoard {
  num? gpnl;
  num? brokerage;
  String? userId;
  String? name;
  int? tradingDays;
  num? npnl;
  int? noOfTrade;
  int? referralCount;
  num? totalreturn;
  String? attendancePercentage;
  String? profileImage;

  InternshipLeaderBoard(
      {this.gpnl,
      this.brokerage,
      this.userId,
      this.name,
      this.tradingDays,
      this.npnl,
      this.noOfTrade,
      this.referralCount,
      this.totalreturn,
      this.attendancePercentage,
      this.profileImage});

  InternshipLeaderBoard.fromJson(Map<String, dynamic> json) {
    gpnl = json['gpnl'];
    brokerage = json['brokerage'];
    userId = json['userId'];
    name = json['name'];
    tradingDays = json['tradingDays'];
    npnl = json['npnl'];
    noOfTrade = json['noOfTrade'];
    referralCount = json['referralCount'];
    totalreturn = json['return'];
    attendancePercentage = json['attendancePercentage'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpnl'] = this.gpnl;
    data['brokerage'] = this.brokerage;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['tradingDays'] = this.tradingDays;
    data['npnl'] = this.npnl;
    data['noOfTrade'] = this.noOfTrade;
    data['referralCount'] = this.referralCount;
    data['return'] = this.totalreturn;
    data['attendancePercentage'] = this.attendancePercentage;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
