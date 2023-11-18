class ContestProfileResponse {
  String? status;
  String? message;
  List<ContestProfile>? data;
  int? length;

  ContestProfileResponse({this.status, this.message, this.data, this.length});

  ContestProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContestProfile>[];
      json['data'].forEach((v) {
        data!.add(new ContestProfile.fromJson(v));
      });
    }
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['length'] = this.length;
    return data;
  }
}

class ContestProfile {
  String? sId;
  String? contestName;
  String? contestStartTime;
  String? contestFor;
  num? entryFee;
  num? payout;
  int? rank;
  num? tds;
  String? trader;
  String? userid;
  String? firstName;
  String? lastName;
  ProfilePicture? profilePicture;
  String? joiningDate;
  num? finalPayout;

  ContestProfile(
      {this.sId,
      this.contestName,
      this.contestStartTime,
      this.contestFor,
      this.entryFee,
      this.payout,
      this.rank,
      this.tds,
      this.trader,
      this.userid,
      this.firstName,
      this.lastName,
      this.profilePicture,
      this.joiningDate,
      this.finalPayout});

  ContestProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestFor = json['contestFor'];
    entryFee = json['entryFee'];
    payout = json['payout'];
    rank = json['rank'];
    tds = json['tds'];
    trader = json['trader'];
    userid = json['userid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePicture = json['profile_picture'] != null
        ? new ProfilePicture.fromJson(json['profile_picture'])
        : null;
    joiningDate = json['joining_date'];
    finalPayout = json['finalPayout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contestName'] = this.contestName;
    data['contestStartTime'] = this.contestStartTime;
    data['contestFor'] = this.contestFor;
    data['entryFee'] = this.entryFee;
    data['payout'] = this.payout;
    data['rank'] = this.rank;
    data['tds'] = this.tds;
    data['trader'] = this.trader;
    data['userid'] = this.userid;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.profilePicture != null) {
      data['profile_picture'] = this.profilePicture!.toJson();
    }
    data['joining_date'] = this.joiningDate;
    data['finalPayout'] = this.finalPayout;
    return data;
  }
}

class ProfilePicture {
  String? url;
  String? name;

  ProfilePicture({this.url, this.name});

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}
