class LiveCollegeContestListResponse {
  String? status;
  String? message;
  List<LiveCollegeContest>? data;

  LiveCollegeContestListResponse({this.status, this.message, this.data});

  LiveCollegeContestListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LiveCollegeContest>[];
      json['data'].forEach((v) {
        data!.add(new LiveCollegeContest.fromJson(v));
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

class LiveCollegeContest {
  String? sId;
  String? contestName;
  String? contestStartTime;
  String? contestEndTime;
  String? description;
  String? contestType;
  String? currentLiveStatus;
  String? contestFor;
  int? entryFee;
  double? payoutPercentage;
  LiveCollegeContestPortfolio? portfolio;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  bool? isAllIndex;
  List<Null>? rewards;
  List<LiveCollegeInterestedUsers>? interestedUsers;
  List<CollegeParticipants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;

  LiveCollegeContest(
      {this.sId,
      this.contestName,
      this.contestStartTime,
      this.contestEndTime,
      this.description,
      this.contestType,
      this.currentLiveStatus,
      this.contestFor,
      this.entryFee,
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
      this.rewards,
      this.interestedUsers,
      this.participants,
      this.createdOn,
      this.lastModifiedOn,
      this.iV});

  LiveCollegeContest.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    currentLiveStatus = json['currentLiveStatus'];
    contestFor = json['contestFor'];
    entryFee = json['entryFee'];
    payoutPercentage = json['payoutPercentage'];
    portfolio = json['portfolio'] != null
        ? new LiveCollegeContestPortfolio.fromJson(json['portfolio'])
        : null;
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    isAllIndex = json['isAllIndex'];
    if (json['rewards'] != null) {
      rewards = <Null>[];
      json['rewards'].forEach((v) {
        // rewards!.add(new Null.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = <LiveCollegeInterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new LiveCollegeInterestedUsers.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <CollegeParticipants>[];
      json['participants'].forEach((v) {
        participants!.add(new CollegeParticipants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contestName'] = this.contestName;
    data['contestStartTime'] = this.contestStartTime;
    data['contestEndTime'] = this.contestEndTime;
    data['description'] = this.description;
    data['contestType'] = this.contestType;
    data['currentLiveStatus'] = this.currentLiveStatus;
    data['contestFor'] = this.contestFor;
    data['entryFee'] = this.entryFee;
    data['payoutPercentage'] = this.payoutPercentage;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    data['maxParticipants'] = this.maxParticipants;
    data['contestStatus'] = this.contestStatus;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['contestExpiry'] = this.contestExpiry;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    data['isAllIndex'] = this.isAllIndex;
    if (this.rewards != null) {
      // data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] = this.interestedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    return data;
  }
}

class LiveCollegeContestPortfolio {
  String? sId;
  String? portfolioName;
  int? portfolioValue;

  LiveCollegeContestPortfolio({this.sId, this.portfolioName, this.portfolioValue});

  LiveCollegeContestPortfolio.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    portfolioName = json['portfolioName'];
    portfolioValue = json['portfolioValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['portfolioName'] = this.portfolioName;
    data['portfolioValue'] = this.portfolioValue;
    return data;
  }
}

class LiveCollegeInterestedUsers {
  UserIdd? userId;
  String? registeredOn;
  String? status;
  String? sId;

  LiveCollegeInterestedUsers({this.userId, this.registeredOn, this.status, this.sId});

  LiveCollegeInterestedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? new UserIdd.fromJson(json['userId']) : null;
    registeredOn = json['registeredOn'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['registeredOn'] = this.registeredOn;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class UserIdd {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? creationProcess;

  UserIdd({this.sId, this.firstName, this.lastName, this.email, this.mobile, this.creationProcess});

  UserIdd.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    creationProcess = json['creationProcess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['creationProcess'] = this.creationProcess;
    return data;
  }
}

class CollegeParticipants {
  UserIdd? userId;
  String? participatedOn;
  bool? isLive;
  String? sId;

  CollegeParticipants({this.userId, this.participatedOn, this.isLive, this.sId});

  CollegeParticipants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? new UserIdd.fromJson(json['userId']) : null;
    participatedOn = json['participatedOn'];
    isLive = json['isLive'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['participatedOn'] = this.participatedOn;
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    return data;
  }
}
