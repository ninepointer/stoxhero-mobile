class FeaturedContestResponse {
  String? status;
  String? message;
  List<LiveFeatured>? liveFeatured;
  List<UpcomingFeatured>? upcomingFeatured;
  List<FeaturedCollegeContest>? collegeContest;

  FeaturedContestResponse({
    this.status,
    this.message,
    this.liveFeatured,
    this.upcomingFeatured,
    this.collegeContest,
  });

  FeaturedContestResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['stoxheroLiveFeatured'] != null) {
      liveFeatured = <LiveFeatured>[];
      json['stoxheroLiveFeatured'].forEach((v) {
        liveFeatured!.add(new LiveFeatured.fromJson(v));
      });
    }
    if (json['stoxheroUpcomingFeatured'] != null) {
      upcomingFeatured = <UpcomingFeatured>[];
      json['stoxheroUpcomingFeatured'].forEach((v) {
        upcomingFeatured!.add(new UpcomingFeatured.fromJson(v));
      });
    }
    if (json['collegeContests'] != null) {
      collegeContest = <FeaturedCollegeContest>[];
      json['collegeContests'].forEach((v) {
        collegeContest!.add(new FeaturedCollegeContest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.liveFeatured != null) {
      data['stoxheroLiveFeatured'] =
          this.liveFeatured!.map((v) => v.toJson()).toList();
    }
    if (this.upcomingFeatured != null) {
      data['stoxheroUpcomingFeatured'] =
          this.upcomingFeatured!.map((v) => v.toJson()).toList();
    }
    if (this.collegeContest != null) {
      data['collegeContests'] =
          this.collegeContest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveFeatured {
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
  FeaturedPortfolio? portfolio;
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
  List<FeaturedRewards>? rewards;
  List<FeaturedParticipants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;
  num? liveThreshold;
  String? payoutType;
  String? rewardType;

  LiveFeatured({
    this.id,
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
    this.participants,
    this.createdOn,
    this.lastModifiedOn,
    this.iV,
    this.liveThreshold,
    this.payoutType,
    this.rewardType,
  });

  LiveFeatured.fromJson(Map<String, dynamic> json) {
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
    portfolio = json['portfolio'] != null
        ? new FeaturedPortfolio.fromJson(json['portfolio'])
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
    rewardType = json['rewardType'];
    product = json['product'];
    payoutCapPercentage = json['payoutCapPercentage'];
    if (json['rewards'] != null) {
      rewards = <FeaturedRewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new FeaturedRewards.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <FeaturedParticipants>[];
      json['participants'].forEach((v) {
        participants!.add(new FeaturedParticipants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
    liveThreshold = json['liveThreshold'];
    payoutType = json['payoutType'];
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
    data['rewardType'] = this.rewardType;
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
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    data['liveThreshold'] = this.liveThreshold;
    data['payoutType'] = this.payoutType;
    return data;
  }
}

class FeaturedPortfolio {
  String? id;
  String? portfolioName;
  num? portfolioValue;

  FeaturedPortfolio({this.id, this.portfolioName, this.portfolioValue});

  FeaturedPortfolio.fromJson(Map<String, dynamic> json) {
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

class FeaturedRewards {
  int? rankStart;
  int? rankEnd;
  String? sId;
  dynamic prize; // Change the type to dynamic

  FeaturedRewards({this.rankStart, this.rankEnd, this.sId, this.prize});

  // Factory method to create a Rewards instance from JSON
  factory FeaturedRewards.fromJson(Map<String, dynamic> json) {
    return FeaturedRewards(
      rankStart: json['rankStart'],
      rankEnd: json['rankEnd'],
      sId: json['_id'],
      prize: json['prize'],
    );
  }

  // Convert the instance to a JSON representation
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'rankStart': rankStart,
      'rankEnd': rankEnd,
      '_id': sId,
    };

    // Check the type of prize and add it to the JSON
    if (prize is String) {
      data['prize'] = prize;
    } else if (prize is num) {
      data['prize'] = prize;
    }

    return data;
  }
}

class FeaturedParticipants {
  FeaturedUserId? userId;
  num? fee;
  num? actualPrice;
  String? participatedOn;
  bool? isLive;
  String? id;

  FeaturedParticipants({
    this.userId,
    this.fee,
    this.actualPrice,
    this.participatedOn,
    this.isLive,
    this.id,
  });

  FeaturedParticipants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null
        ? new FeaturedUserId.fromJson(json['userId'])
        : null;
    fee = json['fee'];
    actualPrice = json['actualPrice'];
    participatedOn = json['participatedOn'];
    isLive = json['isLive'];
    id = json['_id'];
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
    data['_id'] = this.id;
    return data;
  }
}

class FeaturedUserId {
  String? id;
  String? creationProcess;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;

  FeaturedUserId({
    this.id,
    this.creationProcess,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
  });

  FeaturedUserId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    creationProcess = json['creationProcess'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['creationProcess'] = this.creationProcess;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    return data;
  }
}

class UpcomingFeatured {
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
  String? payoutType;
  FeaturedPortfolio? portfolio;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  String? product;
  num? payoutCapPercentage;
  List<FeaturedUpcomingRewards>? rewards;
  List<FeaturedInterestedUsers>? interestedUsers;
  List<FeaturedParticipants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  String? rewardType;
  int? iV;

  UpcomingFeatured(
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
      this.payoutType,
      this.portfolio,
      this.maxParticipants,
      this.contestStatus,
      this.createdBy,
      this.lastModifiedBy,
      this.contestExpiry,
      this.rewardType,
      this.isNifty,
      this.isBankNifty,
      this.isFinNifty,
      this.product,
      this.payoutCapPercentage,
      this.rewards,
      this.interestedUsers,
      this.participants,
      this.createdOn,
      this.lastModifiedOn,
      this.iV});

  UpcomingFeatured.fromJson(Map<String, dynamic> json) {
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
    payoutType = json['payoutType'];
    rewardType = json["rewardType"];
    if (json['rewards'] != null) {
      rewards = (json['rewards'] as List<dynamic>)
          .map((v) => FeaturedUpcomingRewards.fromJson(v))
          .toList();
    } else {
      rewards = [];
    }
    portfolio = json['portfolio'] != null
        ? new FeaturedPortfolio.fromJson(json['portfolio'])
        : null;
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    product = json['product'];
    payoutCapPercentage = json['payoutCapPercentage'];
    if (json['interestedUsers'] != null) {
      interestedUsers = <FeaturedInterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new FeaturedInterestedUsers.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <FeaturedParticipants>[];
      json['participants'].forEach((v) {
        participants!.add(new FeaturedParticipants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
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
    data['payoutType'] = this.payoutType;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    data['maxParticipants'] = this.maxParticipants;
    data['contestStatus'] = this.contestStatus;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['contestExpiry'] = this.contestExpiry;
    data["rewardType"] = this.rewardType;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    data['product'] = this.product;
    data['payoutCapPercentage'] = this.payoutCapPercentage;
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] =
          this.interestedUsers!.map((v) => v.toJson()).toList();
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

class FeaturedUpcomingRewards {
  int? rankStart;
  int? rankEnd;
  String? sId;
  dynamic prize; // Change the type to dynamic

  FeaturedUpcomingRewards({this.rankStart, this.rankEnd, this.sId, this.prize});

  // Factory method to create a Rewards instance from JSON
  factory FeaturedUpcomingRewards.fromJson(Map<String, dynamic> json) {
    return FeaturedUpcomingRewards(
      rankStart: json['rankStart'],
      rankEnd: json['rankEnd'],
      sId: json['_id'],
      prize: json['prize'],
    );
  }

  // Convert the instance to a JSON representation
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'rankStart': rankStart,
      'rankEnd': rankEnd,
      '_id': sId,
    };

    // Check the type of prize and add it to the JSON
    if (prize is String) {
      data['prize'] = prize;
    } else if (prize is num) {
      data['prize'] = prize;
    }

    return data;
  }
}

class FeaturedInterestedUsers {
  FeaturedUserId? userId;
  String? registeredOn;
  String? status;
  String? sId;

  FeaturedInterestedUsers(
      {this.userId, this.registeredOn, this.status, this.sId});

  FeaturedInterestedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null
        ? new FeaturedUserId.fromJson(json['userId'])
        : null;
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

class FeaturedCollegeContest {
  String? id;
  String? contestName;
  String? contestStartTime;
  String? contestEndTime;
  String? description;
  String? contestType;
  String? currentLiveStatus;
  String? contestFor;
  String? collegeCode;
  num? entryFee;
  num? payoutPercentage;
  bool? featured;
  String? payoutType;
  FeaturedPortfolio? portfolio;
  String? college;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  String? payoutPercentageType;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  String? product;
  num? payoutCapPercentage;
  List<FeaturedParticipants>? participants;
  List<FeaturedUpcomingRewards>? rewards;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;
  String? rewardType;

  FeaturedCollegeContest(
      {this.id,
      this.contestName,
      this.contestStartTime,
      this.contestEndTime,
      this.description,
      this.contestType,
      this.currentLiveStatus,
      this.contestFor,
      this.collegeCode,
      this.entryFee,
      this.payoutPercentage,
      this.featured,
      this.payoutType,
      this.portfolio,
      this.rewards,
      this.college,
      this.maxParticipants,
      this.contestStatus,
      this.createdBy,
      this.lastModifiedBy,
      this.contestExpiry,
      this.payoutPercentageType,
      this.isNifty,
      this.isBankNifty,
      this.isFinNifty,
      this.product,
      this.payoutCapPercentage,
      this.participants,
      this.createdOn,
      this.lastModifiedOn,
      this.rewardType,
      this.iV});

  FeaturedCollegeContest.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    currentLiveStatus = json['currentLiveStatus'];
    contestFor = json['contestFor'];
    collegeCode = json['collegeCode'];
    entryFee = json['entryFee'];
    payoutPercentage = json['payoutPercentage'];
    featured = json['featured'];
    payoutType = json['payoutType'];
    if (json['rewards'] != null) {
      rewards = (json['rewards'] as List<dynamic>)
          .map((v) => FeaturedUpcomingRewards.fromJson(v))
          .toList();
    } else {
      rewards = [];
    }
    portfolio = json['portfolio'] != null
        ? new FeaturedPortfolio.fromJson(json['portfolio'])
        : null;
    college = json['college'];
    rewardType = json["rewardType"];
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    payoutPercentageType = json['payoutPercentageType'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    product = json['product'];
    payoutCapPercentage = json['payoutCapPercentage'];
    if (json['participants'] != null) {
      participants = <FeaturedParticipants>[];
      json['participants'].forEach((v) {
        participants!.add(new FeaturedParticipants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
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
    data['collegeCode'] = this.collegeCode;
    data['entryFee'] = this.entryFee;
    data['payoutPercentage'] = this.payoutPercentage;
    data['featured'] = this.featured;
    data['payoutType'] = this.payoutType;
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    data['college'] = this.college;
    data["rewardType"] = this.rewardType;
    data['maxParticipants'] = this.maxParticipants;
    data['contestStatus'] = this.contestStatus;
    data['createdBy'] = this.createdBy;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['contestExpiry'] = this.contestExpiry;
    data['payoutPercentageType'] = this.payoutPercentageType;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    data['product'] = this.product;
    data['payoutCapPercentage'] = this.payoutCapPercentage;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }

    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    return data;
  }
}
