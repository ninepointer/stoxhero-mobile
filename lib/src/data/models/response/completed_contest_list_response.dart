class CompletedContestListResponse {
  String? status;
  String? message;
  List<CompletedContest>? data;

  CompletedContestListResponse({
    this.status,
    this.message,
    this.data,
  });

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
  String? contestFor;
  int? entryFee;
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
  String? createdOn;
  String? lastModifiedOn;
  String? payoutStatus;

  CompletedContest({
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
    this.payoutStatus,
  });

  CompletedContest.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    contestName = json['contestName'];
    contestStartTime = json['contestStartTime'];
    contestEndTime = json['contestEndTime'];
    description = json['description'];
    contestType = json['contestType'];
    contestFor = json['contestFor'];
    entryFee = json['entryFee'];
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
    createdOn = json['createdOn'];
    lastModifiedOn = json['lastModifiedOn'];
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
    data['contestFor'] = this.contestFor;
    data['entryFee'] = this.entryFee;
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
    data['createdOn'] = this.createdOn;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['payoutStatus'] = this.payoutStatus;
    return data;
  }
}
