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
  CollegePortfolio? portfolio;
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
  List<LiveCollegeRewards>? rewards;
  List<CollegeParticipants>? participants;
  String? createdOn;
  String? lastModifiedOn;
  int? iV;

  LiveCollegeContest({
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
    this.participants,
    this.createdOn,
    this.lastModifiedOn,
    this.iV,
  });

  LiveCollegeContest.fromJson(Map<String, dynamic> json) {
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
    portfolio = json['portfolio'] != null
        ? new CollegePortfolio.fromJson(json['portfolio'])
        : null;
    college = json['college'];
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
      rewards = <LiveCollegeRewards>[];
      json['rewards'].forEach((v) {
        rewards!.add(new LiveCollegeRewards.fromJson(v));
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

    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['__v'] = this.iV;
    return data;
  }
}

// class LiveCollegeRewards {
//   int? rankStart;
//   int? rankEnd;
//   num? prize;
//   String? id;

//   LiveCollegeRewards({this.rankStart, this.rankEnd, this.prize, this.id});

//   LiveCollegeRewards.fromJson(Map<String, dynamic> json) {
//     rankStart = json['rankStart'];
//     rankEnd = json['rankEnd'];
//     prize = json['prize'];
//     id = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rankStart'] = this.rankStart;
//     data['rankEnd'] = this.rankEnd;
//     data['prize'] = this.prize;
//     data['_id'] = this.id;
//     return data;
//   }
// }
class LiveCollegeRewards {
  int? rankStart;
  int? rankEnd;
  String? sId;
  dynamic prize; // Change the type to dynamic

  LiveCollegeRewards({this.rankStart, this.rankEnd, this.sId, this.prize});

  // Factory method to create a Rewards instance from JSON
  factory LiveCollegeRewards.fromJson(Map<String, dynamic> json) {
    return LiveCollegeRewards(
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

class CollegePortfolio {
  String? sId;
  String? portfolioName;
  num? portfolioValue;

  CollegePortfolio({this.sId, this.portfolioName, this.portfolioValue});

  CollegePortfolio.fromJson(Map<String, dynamic> json) {
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

class CollegeParticipants {
  CollegeUserId? userId;
  String? participatedOn;
  String? sId;
  num? fee;
  num? actualPrice;
  bool? isLive;

  CollegeParticipants(
      {this.userId,
      this.participatedOn,
      this.sId,
      this.fee,
      this.actualPrice,
      this.isLive});

  CollegeParticipants.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null
        ? new CollegeUserId.fromJson(json['userId'])
        : null;
    participatedOn = json['participatedOn'];
    sId = json['_id'];
    fee = json['fee'];
    actualPrice = json['actualPrice'];
    isLive = json['isLive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['participatedOn'] = this.participatedOn;
    data['_id'] = this.sId;
    data['fee'] = this.fee;
    data['actualPrice'] = this.actualPrice;
    data['isLive'] = this.isLive;
    return data;
  }
}

class CollegeUserId {
  String? sId;
  String? creationProcess;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;

  CollegeUserId(
      {this.sId,
      this.creationProcess,
      this.email,
      this.firstName,
      this.lastName,
      this.mobile});

  CollegeUserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    creationProcess = json['creationProcess'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['creationProcess'] = this.creationProcess;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile'] = this.mobile;
    return data;
  }
}
