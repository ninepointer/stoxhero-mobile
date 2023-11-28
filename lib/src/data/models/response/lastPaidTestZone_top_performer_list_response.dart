class LastPaidTestZoneTopPerformerListResponse {
  String? status;
  String? message;
  List<ContestData>? data;
  String? date;

  LastPaidTestZoneTopPerformerListResponse(
      {this.status, this.message, this.data, this.date});

  LastPaidTestZoneTopPerformerListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ContestData>[];
      json['data'].forEach((v) {
        data!.add(new ContestData.fromJson(v));
      });
    }
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class ContestData {
  String? sId;
  String? contestName;
  num? entryFee;
  String? contestDate;
  List<LastPaidTestZoneTopPerformer>? topParticipants;

  ContestData(
      {this.sId,
      this.contestName,
      this.entryFee,
      this.contestDate,
      this.topParticipants});

  ContestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contestName = json['contestName'];
    entryFee = json['entryFee'];
    contestDate = json['contestDate'];
    if (json['topParticipants'] != null) {
      topParticipants = <LastPaidTestZoneTopPerformer>[];
      json['topParticipants'].forEach((v) {
        topParticipants!.add(new LastPaidTestZoneTopPerformer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contestName'] = this.contestName;
    data['entryFee'] = this.entryFee;
    data['contestDate'] = this.contestDate;
    if (this.topParticipants != null) {
      data['topParticipants'] =
          this.topParticipants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastPaidTestZoneTopPerformer {
  String? employeeid;
  String? firstName;
  String? lastName;
  ContestProfilePhoto? profilePhoto;
  num? payout;
  num? tds;
  int? rank;

  LastPaidTestZoneTopPerformer(
      {this.employeeid,
      this.firstName,
      this.lastName,
      this.profilePhoto,
      this.payout,
      this.tds,
      this.rank});

  LastPaidTestZoneTopPerformer.fromJson(Map<String, dynamic> json) {
    employeeid = json['employeeid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePhoto = json['profilePhoto'] != null
        ? new ContestProfilePhoto.fromJson(json['profilePhoto'])
        : null;
    payout = json['payout'];
    tds = json['tds'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeid'] = this.employeeid;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.profilePhoto != null) {
      data['profilePhoto'] = this.profilePhoto!.toJson();
    }
    data['payout'] = this.payout;
    data['tds'] = this.tds;
    data['rank'] = this.rank;
    return data;
  }
}

class ContestProfilePhoto {
  String? url;
  String? name;

  ContestProfilePhoto({this.url, this.name});

  ContestProfilePhoto.fromJson(Map<String, dynamic> json) {
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
