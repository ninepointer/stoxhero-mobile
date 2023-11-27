import '../../../app/app.dart';

class WeeklyTopPerformersListResponse {
  String? status;
  String? message;
  List<WeeklyTopPerformers>? data;
  String? startOfWeek;
  String? endOfWeek;

  WeeklyTopPerformersListResponse(
      {this.status, this.message, this.data, this.startOfWeek, this.endOfWeek});

  WeeklyTopPerformersListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WeeklyTopPerformers>[];
      json['data'].forEach((v) {
        data!.add(new WeeklyTopPerformers.fromJson(v));
      });
    }
    startOfWeek = json['startOfWeek'];
    endOfWeek = json['endOfWeek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['startOfWeek'] = this.startOfWeek;
    data['endOfWeek'] = this.endOfWeek;
    return data;
  }
}

class WeeklyTopPerformers {
  num? payout;
  num? tds;
  int? contests;
  int? contestsWon;
  String? trader;
  String? firstName;
  String? lastName;
  String? userid;
  ProfilePicture? profilePicture;
  num? totalPayout;
  num? strikeRate;

  WeeklyTopPerformers({
    this.payout,
    this.tds,
    this.contests,
    this.contestsWon,
    this.trader,
    this.firstName,
    this.lastName,
    this.userid,
    this.profilePicture,
    this.totalPayout,
    this.strikeRate,
  });

  WeeklyTopPerformers.fromJson(Map<String, dynamic> json) {
    payout = json['payout'];
    tds = json['tds'];
    contests = json['contests'];
    contestsWon = json['contestsWon'];
    trader = json['trader'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userid = json['userid'];
    profilePicture = json['profile_picture'] != null
        ? new ProfilePicture.fromJson(json['profile_picture'])
        : null;
    totalPayout = json['totalPayout'];
    strikeRate = json['strikeRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payout'] = this.payout;
    data['tds'] = this.tds;
    data['contests'] = this.contests;
    data['contestsWon'] = this.contestsWon;
    data['trader'] = this.trader;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['userid'] = this.userid;
    if (this.profilePicture != null) {
      data['profile_picture'] = this.profilePicture!.toJson();
    }
    data['totalPayout'] = this.totalPayout;
    data['strikeRate'] = this.strikeRate;
    return data;
  }
}
