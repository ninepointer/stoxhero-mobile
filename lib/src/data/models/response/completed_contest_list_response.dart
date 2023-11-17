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
  String? product;
  num? payoutCapPercentage;
  List<CompletedRewards>? rewards;
  List<CompletedInterestedUsers>? interestedUsers;
  List<CompletedPurchaseIntent>? purchaseIntent;
  List<CompletedParticipants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  num? dV;
  String? payoutType;
  String? payoutStatus;
  int? liveThreshold;

  CompletedContest({
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
    this.interestedUsers,
    this.purchaseIntent,
    this.participants,
    this.createdOn,
    this.lastModifiedOn,
    this.dV,
    this.payoutType,
    this.payoutStatus,
    this.liveThreshold,
  });

  CompletedContest.fromJson(Map<String, dynamic> json) {
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
    product = json['product'];
    payoutCapPercentage = json['payoutCapPercentage'];
    if (json['rewards'] != null) {
      rewards = <CompletedRewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new CompletedRewards.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = <CompletedInterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new CompletedInterestedUsers.fromJson(v));
      });
    }
    if (json['purchaseIntent'] != null) {
      purchaseIntent = <CompletedPurchaseIntent>[];
      json['purchaseIntent'].forEach((v) {
        purchaseIntent!.add(new CompletedPurchaseIntent.fromJson(v));
      });
    }
    if (json['participants'] != null) {
      participants = <CompletedParticipants>[];
      json['participants'].forEach((v) {
        participants!.add(new CompletedParticipants.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    dV = json['__v'];
    payoutType = json['payoutType'];
    payoutStatus = json['payoutStatus'];
    liveThreshold = json['liveThreshold'];
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
    data['product'] = this.product;
    data['payoutCapPercentage'] = this.payoutCapPercentage;
    if (this.rewards != null) {
      data['rewards'] = this.rewards!.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] = this.interestedUsers!.map((v) => v.toJson()).toList();
    }
    if (this.purchaseIntent != null) {
      data['purchaseIntent'] = this.purchaseIntent!.map((v) => v.toJson()).toList();
    }
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.dV;
    data['payoutType'] = this.payoutType;
    data['payoutStatus'] = this.payoutStatus;
    data['liveThreshold'] = this.liveThreshold;
    return data;
  }
}

class CompletedRewards {
  String? id;
  int? rankStart;
  int? rankEnd;
  num? prize;

  CompletedRewards({
    this.id,
    this.rankStart,
    this.rankEnd,
    this.prize,
  });

  CompletedRewards.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    rankStart = json['rankStart'];
    rankEnd = json['rankEnd'];
    prize = json['prize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['rankStart'] = this.rankStart;
    data['rankEnd'] = this.rankEnd;
    data['prize'] = this.prize;
    return data;
  }
}

class CompletedInterestedUsers {
  String? userId;
  String? registeredOn;
  String? status;
  String? sId;

  CompletedInterestedUsers({this.userId, this.registeredOn, this.status, this.sId});

  CompletedInterestedUsers.fromJson(Map<String, dynamic> json) {
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

class CompletedPurchaseIntent {
  String? userId;
  String? date;
  String? sId;

  CompletedPurchaseIntent({this.userId, this.date, this.sId});

  CompletedPurchaseIntent.fromJson(Map<String, dynamic> json) {
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

class CompletedParticipants {
  String? userId;
  num? fee;
  num? actualPrice;
  String? participatedOn;
  bool? isLive;
  String? sId;
  int? rank;
  num? brokerage;
  num? gpnl;
  num? npnl;
  num? payout;
  num? tdsAmount;
  int? trades;

  CompletedParticipants(
      {this.userId,
      this.fee,
      this.actualPrice,
      this.participatedOn,
      this.isLive,
      this.sId,
      this.rank,
      this.brokerage,
      this.gpnl,
      this.npnl,
      this.payout,
      this.tdsAmount,
      this.trades});

  CompletedParticipants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fee = json['fee'];
    actualPrice = json['actualPrice'];
    participatedOn = json['participatedOn'];
    isLive = json['isLive'];
    sId = json['_id'];
    rank = json['rank'];
    brokerage = json['brokerage'];
    gpnl = json['gpnl'];
    npnl = json['npnl'];
    payout = json['payout'];
    tdsAmount = json['tdsAmount'];
    trades = json['trades'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fee'] = this.fee;
    data['actualPrice'] = this.actualPrice;
    data['participatedOn'] = this.participatedOn;
    data['isLive'] = this.isLive;
    data['_id'] = this.sId;
    data['rank'] = this.rank;
    data['brokerage'] = this.brokerage;
    data['gpnl'] = this.gpnl;
    data['npnl'] = this.npnl;
    data['payout'] = this.payout;
    data['tdsAmount'] = this.tdsAmount;
    data['trades'] = this.trades;
    return data;
  }
}
