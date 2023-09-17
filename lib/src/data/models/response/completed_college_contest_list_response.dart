class CompletedCollegeContestListResponse {
  String? status;
  String? message;
  List<CompletedCollegeContest>? data;

  CompletedCollegeContestListResponse({this.status, this.message, this.data});

  CompletedCollegeContestListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CompletedCollegeContest>[];
      json['data'].forEach((v) {
        data!.add(new CompletedCollegeContest.fromJson(v));
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

class CompletedCollegeContest {
  String? sId;
  String? contestName;
  String? contestStartTime;
  String? contestEndTime;
  String? description;
  String? contestType;
  String? contestFor;
  String? collegeCode;
  num? payoutPercentage;
  String? portfolio;
  String? college;
  List<String>? potentialParticipants;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  bool? isAllIndex;
  List<InterestedUsers>? interestedUsers;
  List<ContestSharedBy>? contestSharedBy;
  List<Null>? allowedUsers;
  List<Participants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;
  String? payoutStatus;
  int? entryFee;
  List<Null>? rewards;
  List<Null>? purchaseIntent;

  CompletedCollegeContest(
      {this.sId,
      this.contestName,
      this.contestStartTime,
      this.contestEndTime,
      this.description,
      this.contestType,
      this.contestFor,
      this.collegeCode,
      this.payoutPercentage,
      this.portfolio,
      this.college,
      this.potentialParticipants,
      this.maxParticipants,
      this.contestStatus,
      this.createdBy,
      this.lastModifiedBy,
      this.contestExpiry,
      this.isNifty,
      this.isBankNifty,
      this.isFinNifty,
      this.isAllIndex,
      this.interestedUsers,
      this.contestSharedBy,
      this.allowedUsers,
      this.participants,
      this.createdOn,
      this.lastModifiedOn,
      this.iV,
      this.payoutStatus,
      this.entryFee,
      this.rewards,
      this.purchaseIntent});

  CompletedCollegeContest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    contestFor = json['contestFor'];
    collegeCode = json['collegeCode'];
    payoutPercentage = json['payoutPercentage'];
    portfolio = json['portfolio'];
    college = json['college'];
    potentialParticipants = json['potentialParticipants'].cast<String>();
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    isAllIndex = json['isAllIndex'];
    if (json['interestedUsers'] != null) {
      interestedUsers = <InterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new InterestedUsers.fromJson(v));
      });
    }
    if (json['contestSharedBy'] != null) {
      contestSharedBy = <ContestSharedBy>[];
      json['contestSharedBy'].forEach((v) {
        contestSharedBy!.add(new ContestSharedBy.fromJson(v));
      });
    }
    if (json['allowedUsers'] != null) {
      allowedUsers = <Null>[];
      json['allowedUsers'].forEach((v) {
        // allowedUsers!.add(new Null.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
    payoutStatus = json['payoutStatus'];
    entryFee = json['entryFee'];
    if (json['rewards'] != null) {
      rewards = <Null>[];
      json['rewards'].forEach((v) {
        // rewards!.add(new Null.fromJson(v));
      });
    }
    if (json['purchaseIntent'] != null) {
      purchaseIntent = <Null>[];
      json['purchaseIntent'].forEach((v) {
        // purchaseIntent!.add(new Null.fromJson(v));
      });
    }
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
    data['collegeCode'] = this.collegeCode;
    data['payoutPercentage'] = this.payoutPercentage;
    data['portfolio'] = this.portfolio;
    data['college'] = this.college;
    data['potentialParticipants'] = this.potentialParticipants;
    data['maxParticipants'] = this.maxParticipants;
    data['contestStatus'] = this.contestStatus;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['contestExpiry'] = this.contestExpiry;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    data['isAllIndex'] = this.isAllIndex;
    if (this.interestedUsers != null) {
      data['interestedUsers'] = this.interestedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.contestSharedBy != null) {
      data['contestSharedBy'] = this.contestSharedBy!.map((v) => v.toJson()).toList();
    }
    if (this.allowedUsers != null) {
      // data['allowedUsers'] = this.allowedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    data['payoutStatus'] = this.payoutStatus;
    data['entryFee'] = this.entryFee;
    if (this.rewards != null) {
      // data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    if (this.purchaseIntent != null) {
      // data['purchaseIntent'] = this.purchaseIntent!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InterestedUsers {
  String? userId;
  String? registeredOn;
  String? status;
  String? sId;

  InterestedUsers({this.userId, this.registeredOn, this.status, this.sId});

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

class Participants {
  String? userId;
  String? participatedOn;
  String? sId;
  double? payout;

  Participants({this.userId, this.participatedOn, this.sId, this.payout});

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    participatedOn = json['participatedOn'];
    sId = json['_id'];
    payout = json['payout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['participatedOn'] = this.participatedOn;
    data['_id'] = this.sId;
    data['payout'] = this.payout;
    return data;
  }
}
