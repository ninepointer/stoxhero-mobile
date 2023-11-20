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
  String? portfolio;
  String? college;
  List<String>? potentialParticipants;
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
  List<CompletedCollegeRewards>? rewards;
  List<CollegeInterestedUsers>? interestedUsers;
  List<ContestSharedBy>? contestSharedBy;
  List<PurchaseIntent>? purchaseIntent;
  List<CollegeParticipantss>? participants;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;
  String? payoutStatus;

  CompletedCollegeContest({
    this.id,
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
    this.college,
    this.potentialParticipants,
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
    this.rewards,
    this.interestedUsers,
    this.contestSharedBy,
    this.purchaseIntent,
    this.participants,
    this.createdOn,
    this.lastModifiedOn,
    this.iV,
    this.payoutStatus,
  });

  CompletedCollegeContest.fromJson(Map<String, dynamic> json) {
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
    portfolio = json['portfolio'];
    college = json['college'];
    potentialParticipants = json['potentialParticipants'].cast<String>();
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
    if (json['rewards'] != null) {
      rewards = <CompletedCollegeRewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new CompletedCollegeRewards.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = <CollegeInterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new CollegeInterestedUsers.fromJson(v));
      });
    }
    if (json['contestSharedBy'] != null) {
      contestSharedBy = <ContestSharedBy>[];
      json['contestSharedBy'].forEach((v) {
        contestSharedBy!.add(new ContestSharedBy.fromJson(v));
      });
    }

    if (json['purchaseIntent'] != null) {
      purchaseIntent = <PurchaseIntent>[];
      json['purchaseIntent'].forEach((v) {
        purchaseIntent!.add(new PurchaseIntent.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <CollegeParticipantss>[];
      json['participants'].forEach((v) {
        participants!.add(new CollegeParticipantss.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    iV = json['__v'];
    payoutStatus = json['payoutStatus'];
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
    data['portfolio'] = this.portfolio;
    data['college'] = this.college;
    data['potentialParticipants'] = this.potentialParticipants;
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
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] = this.interestedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.contestSharedBy != null) {
      data['contestSharedBy'] = this.contestSharedBy!.map((v) => v.toJson()).toList();
    }
    if (this.purchaseIntent != null) {
      data['purchaseIntent'] = this.purchaseIntent!.map((v) => v.toJson()).toList();
    }
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    data['payoutStatus'] = this.payoutStatus;
    return data;
  }
}

class PurchaseIntent {
  String? userId;
  String? date;
  String? sId;

  PurchaseIntent({this.userId, this.date, this.sId});

  PurchaseIntent.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['_id'] = this.sId;
    return data;
  }
}

class CompletedCollegeRewards {
  int? rankStart;
  int? rankEnd;
  num? prize;
  String? id;

  CompletedCollegeRewards({this.rankStart, this.rankEnd, this.prize, this.id});

  CompletedCollegeRewards.fromJson(Map<String, dynamic> json) {
    rankStart = json['rankStart'];
    rankEnd = json['rankEnd'];
    prize = json['prize'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rankStart'] = this.rankStart;
    data['rankEnd'] = this.rankEnd;
    data['prize'] = this.prize;
    data['_id'] = this.id;
    return data;
  }
}

class CollegeParticipantss {
  String? userId;
  num? fee;
  num? actualPrice;
  String? participatedOn;
  bool? isLive;
  String? sId;
  num? brokerage;
  num? gpnl;
  num? npnl;
  num? trades;
  num? rank;
  num? payout;
  num? tdsAmount;

  CollegeParticipantss(
      {this.userId,
      this.fee,
      this.actualPrice,
      this.participatedOn,
      this.isLive,
      this.sId,
      this.brokerage,
      this.gpnl,
      this.npnl,
      this.trades,
      this.rank,
      this.payout,
      this.tdsAmount});

  CollegeParticipantss.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fee = json['fee'];
    actualPrice = json['actualPrice'];
    participatedOn = json['participatedOn'];
    isLive = json['isLive'];
    sId = json['_id'];
    brokerage = json['brokerage'];
    gpnl = json['gpnl'];
    npnl = json['npnl'];
    trades = json['trades'];
    rank = json['rank'];
    payout = json['payout'];
    tdsAmount = json['tdsAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fee'] = this.fee;
    data['actualPrice'] = this.actualPrice;
    data['participatedOn'] = this.participatedOn;
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    data['brokerage'] = this.brokerage;
    data['gpnl'] = this.gpnl;
    data['npnl'] = this.npnl;
    data['trades'] = this.trades;
    data['rank'] = this.rank;
    data['payout'] = this.payout;
    data['tdsAmount'] = this.tdsAmount;
    return data;
  }
}

class CollegeInterestedUsers {
  String? userId;
  String? registeredOn;
  String? status;
  String? id;

  CollegeInterestedUsers({this.userId, this.registeredOn, this.status, this.id});

  CollegeInterestedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    registeredOn = json['registeredOn'];
    status = json['status'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['registeredOn'] = this.registeredOn;
    data['status'] = this.status;
    data['_id'] = this.id;
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
