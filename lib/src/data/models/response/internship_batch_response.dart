class InternshipBatchResponse {
  String? status;
  InternshipBatch? data;

  InternshipBatchResponse({this.status, this.data});

  InternshipBatchResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? new InternshipBatch.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class InternshipBatch {
  String? id;
  String? batchName;
  String? batchStartDate;
  String? batchEndDate;
  num? payoutPercentage;
  num? attendancePercentage;
  int? referralCount;
  Career? career;
  InternPortfolio? portfolio;

  InternshipBatch({
    this.id,
    this.batchName,
    this.batchStartDate,
    this.batchEndDate,
    this.payoutPercentage,
    this.attendancePercentage,
    this.referralCount,
    this.career,
    this.portfolio,
  });

  InternshipBatch.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    batchName = json['batchName'];
    batchStartDate = json['batchStartDate'];
    batchEndDate = json['batchEndDate'];
    payoutPercentage = json['payoutPercentage'];
    attendancePercentage = json['attendancePercentage'];
    referralCount = json['referralCount'];
    career =
        json['career'] != null ? new Career.fromJson(json['career']) : null;
    portfolio = json['portfolio'] != null
        ? new InternPortfolio.fromJson(json['portfolio'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['batchName'] = this.batchName;
    data['batchStartDate'] = this.batchStartDate;
    data['batchEndDate'] = this.batchEndDate;
    data['payoutPercentage'] = this.payoutPercentage;
    data['attendancePercentage'] = this.attendancePercentage;
    data['referralCount'] = this.referralCount;
    if (this.career != null) {
      data['career'] = this.career!.toJson();
    }
    if (this.portfolio != null) {
      data['portfolio'] = this.portfolio!.toJson();
    }
    return data;
  }
}

class Career {
  String? id;
  String? jobTitle;
  String? listingType;

  Career({this.id, this.jobTitle, this.listingType});

  Career.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    jobTitle = json['jobTitle'];
    listingType = json['listingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['jobTitle'] = this.jobTitle;
    data['listingType'] = this.listingType;
    return data;
  }
}

class InternPortfolio {
  String? id;
  num? portfolioValue;

  InternPortfolio({this.id, this.portfolioValue});

  InternPortfolio.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    portfolioValue = json['portfolioValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['portfolioValue'] = this.portfolioValue;
    return data;
  }
}
