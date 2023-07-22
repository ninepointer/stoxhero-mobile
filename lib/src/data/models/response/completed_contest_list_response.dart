import '../models.dart';

class CompletedContestListResponse {
  String? status;
  String? message;
  List<CompletedContest>? data;

  CompletedContestListResponse({this.status, this.message, this.data});

  CompletedContestListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompletedContest>[];
      json['data'].forEach((v) {
        data!.add(new CompletedContest.fromJson(v));
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

class CompletedContest {
  String? sId;
  String? contestName;
  String? contestStartTime;
  String? contestEndTime;
  String? description;
  String? contestType;
  String? contestFor;
  num? payoutPercentage;
  String? portfolio;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  bool? isAllIndex;
  List<Participants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  double? dV;
  List<ContestSharedBy>? contestSharedBy;
  List<InterestedUsers>? interestedUsers;
  String? payoutStatus;
  List<String>? potentialParticipants;

  CompletedContest(
      {this.sId,
      this.contestName,
      this.contestStartTime,
      this.contestEndTime,
      this.description,
      this.contestType,
      this.contestFor,
      this.payoutPercentage,
      this.portfolio,
      this.maxParticipants,
      this.contestStatus,
      this.createdBy,
      this.lastModifiedBy,
      this.contestExpiry,
      this.isNifty,
      this.isBankNifty,
      this.isFinNifty,
      this.isAllIndex,
      this.participants,
      this.createdOn,
      this.lastModifiedOn,
      this.dV,
      this.contestSharedBy,
      this.interestedUsers,
      this.payoutStatus,
      this.potentialParticipants});

  CompletedContest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    contestFor = json['contestFor'];
    payoutPercentage = json['payoutPercentage'];
    portfolio = json['portfolio'];
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    isAllIndex = json['isAllIndex'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    dV = json['__v'];
    if (json['contestSharedBy'] != null) {
      contestSharedBy = <ContestSharedBy>[];
      json['contestSharedBy'].forEach((v) {
        contestSharedBy!.add(new ContestSharedBy.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = <InterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new InterestedUsers.fromJson(v));
      });
    }
    payoutStatus = json['payoutStatus'];
    potentialParticipants = json['potentialParticipants'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contestName'] = this.contestName;
    data['contestStartTime'] = this.contestStartTime;
    data['contestEndTime'] = this.contestEndTime;
    data['description'] = this.description;
    data['contestType'] = this.contestType;
    data['contestFor'] = this.contestFor;
    data['payoutPercentage'] = this.payoutPercentage;
    data['portfolio'] = this.portfolio;
    data['maxParticipants'] = this.maxParticipants;
    data['contestStatus'] = this.contestStatus;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['contestExpiry'] = this.contestExpiry;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    data['isAllIndex'] = this.isAllIndex;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.dV;
    if (this.contestSharedBy != null) {
      data['contestSharedBy'] = this.contestSharedBy!.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] = this.interestedUsers!.map((v) => v.toJson()).toList();
    }
    data['payoutStatus'] = this.payoutStatus;
    data['potentialParticipants'] = this.potentialParticipants;
    return data;
  }
}

class ContestSharedBy {
  String? userId;
  String? sharedAt;
  String? sId;

  ContestSharedBy({this.userId, this.sharedAt, this.sId});

  ContestSharedBy.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    sharedAt = json['sharedAt'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['sharedAt'] = this.sharedAt;
    data['_id'] = this.sId;
    return data;
  }
}

class InterestedUsers {
  String? userId;
  String? registeredOn;
  String? status;
  String? sId;

  InterestedUsers({
    this.userId,
    this.registeredOn,
    this.status,
    this.sId,
  });

  InterestedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    registeredOn = json['registeredOn'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['registeredOn'] = this.registeredOn;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}
