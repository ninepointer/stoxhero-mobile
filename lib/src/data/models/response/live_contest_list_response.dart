class LiveContestListResponse {
  String? status;
  String? message;
  List<LiveContest>? data;

  LiveContestListResponse({this.status, this.message, this.data});

  LiveContestListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LiveContest>[];
      json['data'].forEach((v) {
        data!.add(new LiveContest.fromJson(v));
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

class LiveContest {
  String? id;
  String? contestName;
  String? contestStartTime;
  String? contestEndTime;
  String? description;
  String? contestType;
  String? currentLiveStatus;
  String? contestFor;
  num? entryFee;
  num? payoutPercentage;
  bool? featured;
  LiveContestPortfolio? portfolio;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  bool? isAllIndex;
  String? product;
  num? payoutCapPercentage;
  List<Rewards>? rewards;
  List<LiveInterestedUsers>? interestedUsers;
  List<Participants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;
  String? payoutType;
  String? payoutPercentageType;

  LiveContest(
      {this.id,
      this.contestName,
      this.contestStartTime,
      this.contestEndTime,
      this.description,
      this.contestType,
      this.currentLiveStatus,
      this.contestFor,
      this.entryFee,
      this.payoutPercentage,
      this.featured,
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
      this.product,
      this.payoutCapPercentage,
      this.rewards,
      this.interestedUsers,
      this.participants,
      this.createdOn,
      this.lastModifiedOn,
      this.iV,
      this.payoutType,
      this.payoutPercentageType});

  LiveContest.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    currentLiveStatus = json['currentLiveStatus'];
    contestFor = json['contestFor'];
    entryFee = json['entryFee'];
    payoutPercentage = json['payoutPercentage'];
    featured = json['featured'];
    portfolio = json['portfolio'] != null ? new LiveContestPortfolio.fromJson(json['portfolio']) : null;
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    isAllIndex = json['isAllIndex'];
    product = json['product'];
    payoutCapPercentage = json['payoutCapPercentage'];
    if (json['rewards'] != null) {
      rewards = <Rewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new Rewards.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = <LiveInterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new LiveInterestedUsers.fromJson(v));
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
    payoutType = json['payoutType'];
    payoutPercentageType = json['payoutPercentageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['contestName'] = this.contestName;
    data['contestStartTime'] = this.contestStartTime;
    data['contestEndTime'] = this.contestEndTime;
    data['description'] = this.description;
    data['contestType'] = this.contestType;
    data['currentLiveStatus'] = this.currentLiveStatus;
    data['contestFor'] = this.contestFor;
    data['entryFee'] = this.entryFee;
    data['payoutPercentage'] = this.payoutPercentage;
    data['featured'] = this.featured;
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
    data['product'] = this.product;
    data['payoutCapPercentage'] = this.payoutCapPercentage;
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
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
    data['payoutType'] = this.payoutType;
    data['payoutPercentageType'] = this.payoutPercentageType;
    return data;
  }
}

class LiveContestPortfolio {
  String? id;
  String? portfolioName;
  int? portfolioValue;

  LiveContestPortfolio({this.id, this.portfolioName, this.portfolioValue});

  LiveContestPortfolio.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    portfolioName = json['portfolioName'];
    portfolioValue = json['portfolioValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['portfolioName'] = this.portfolioName;
    data['portfolioValue'] = this.portfolioValue;
    return data;
  }
}

class Rewards {
  int? rankStart;
  int? rankEnd;
  num? prize;
  String? sId;

  Rewards({this.rankStart, this.rankEnd, this.prize, this.sId});

  Rewards.fromJson(Map<String, dynamic> json) {
    rankStart = json['rankStart'];
    rankEnd = json['rankEnd'];
    prize = json['prize'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rankStart'] = this.rankStart;
    data['rankEnd'] = this.rankEnd;
    data['prize'] = this.prize;
    data['_id'] = this.sId;
    return data;
  }
}

class LiveInterestedUsers {
  UserIdc? userId;
  String? registeredOn;
  String? status;
  String? id;

  LiveInterestedUsers({this.userId, this.registeredOn, this.status, this.id});

  LiveInterestedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? new UserIdc.fromJson(json['userId']) : null;
    registeredOn = json['registeredOn'];
    status = json['status'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['registeredOn'] = this.registeredOn;
    data['status'] = this.status;
    data['_id'] = this.id;
    return data;
  }
}

class UserIdc {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;

  UserIdc({this.id, this.email, this.firstName, this.lastName, this.mobile});

  UserIdc.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    return data;
  }
}

class Participants {
  UserIdc? userId;
  num? fee;
  num? actualPrice;
  String? participatedOn;
  bool? isLive;
  String? sId;

  Participants({this.userId, this.fee, this.actualPrice, this.participatedOn, this.isLive, this.sId});

  Participants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? new UserIdc.fromJson(json['userId']) : null;
    fee = json['fee'];
    actualPrice = json['actualPrice'];
    participatedOn = json['participatedOn'];
    isLive = json['isLive'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['fee'] = this.fee;
    data['actualPrice'] = this.actualPrice;
    data['participatedOn'] = this.participatedOn;
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    return data;
  }
}
