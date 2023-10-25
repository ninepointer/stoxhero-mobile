import 'package:stoxhero/src/data/data.dart';

class UpComingContestListResponse {
  String? status;
  String? message;
  List<UpComingContest>? data;

  UpComingContestListResponse({this.status, this.message, this.data});

  UpComingContestListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UpComingContest>[];
      json['data'].forEach((v) {
        data!.add(new UpComingContest.fromJson(v));
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

class UpComingContest {
  String? id;
  String? contestName;
  String? contestStartTime;
  String? contestEndTime;
  String? description;
  String? contestType;
  String? contestFor;
  num? entryFee;
  num? payoutPercentage;
  ContestPortfolio? portfolio;
  int? maxParticipants;
  String? contestStatus;
  String? createdBy;
  String? lastModifiedBy;
  String? contestExpiry;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  bool? isAllIndex;
  String? createdOn;
  String? lastModifiedOn;
  List<Participants>? participants;
  List<InterestedUsers>? interestedUsers;
  num? payoutCapPercentage;

  UpComingContest({
    this.id,
    this.contestName,
    this.contestStartTime,
    this.contestEndTime,
    this.description,
    this.contestType,
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
    this.createdOn,
    this.lastModifiedOn,
    this.participants,
    this.interestedUsers,
    this.payoutCapPercentage,
  });

  UpComingContest.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    contestFor = json['contestFor'];
    entryFee = json['entryFee'];
    payoutPercentage = json['payoutPercentage'];
    portfolio = json['portfolio'] != null ? new ContestPortfolio.fromJson(json['portfolio']) : null;
    maxParticipants = json['maxParticipants'];
    contestStatus = json['contestStatus'];
    createdBy = json['createdBy'];
    lastModifiedBy = json['lastModifiedBy'];
    contestExpiry = json['contestExpiry'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    isAllIndex = json['isAllIndex'];
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    if (json['interestedUsers'] != null) {
      interestedUsers = <InterestedUsers>[];
      json['interestedUsers'].forEach((v) {
        interestedUsers!.add(new InterestedUsers.fromJson(v));
      });
    }
    payoutCapPercentage = json['payoutCapPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['contestName'] = this.contestName;
    data['contestStartTime'] = this.contestStartTime;
    data['contestEndTime'] = this.contestEndTime;
    data['description'] = this.description;
    data['contestType'] = this.contestType;
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
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    if (this.interestedUsers != null) {
      data['interestedUsers'] = this.interestedUsers!.map((v) => v.toJson()).toList();
    }
    data['payoutCapPercentage'] = this.payoutCapPercentage;
    return data;
  }
}

class ContestPortfolio {
  String? id;
  String? portfolioName;
  num? portfolioValue;

  ContestPortfolio({this.id, this.portfolioName, this.portfolioValue});

  ContestPortfolio.fromJson(Map<String, dynamic> json) {
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

class InterestedUsers {
  ContestUserId? userId;
  String? registeredOn;
  String? status;
  String? id;

  InterestedUsers({this.userId, this.registeredOn, this.status, this.id});

  InterestedUsers.fromJson(Map<String, dynamic> json) {
    userId = json['userId'] != null ? new ContestUserId.fromJson(json['userId']) : null;
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

class ContestUserId {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;

  ContestUserId({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
  });

  ContestUserId.fromJson(Map<String, dynamic> json) {
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

class PurchaseIntent {
  String? userId;
  String? date;
  String? id;

  PurchaseIntent({this.userId, this.date, this.id});

  PurchaseIntent.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    date = json['date'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['date'] = this.date;
    data['_id'] = this.id;
    return data;
  }
}
