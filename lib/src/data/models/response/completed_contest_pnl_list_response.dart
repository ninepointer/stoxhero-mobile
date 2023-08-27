class CompletedContestPnlListResponse {
  String? status;
  List<CompletedContestPnl>? data;

  CompletedContestPnlListResponse({this.status, this.data});

  CompletedContestPnlListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CompletedContestPnl>[];
      json['data'].forEach((v) {
        data!.add(new CompletedContestPnl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompletedContestPnl {
  String? contestId;
  num? npnl;
  num? portfolioValue;
  num? payoutAmount;

  CompletedContestPnl({
    this.contestId,
    this.npnl,
    this.portfolioValue,
    this.payoutAmount,
  });

  CompletedContestPnl.fromJson(Map<String, dynamic> json) {
    contestId = json['contestId'];
    npnl = json['npnl'];
    portfolioValue = json['portfolioValue'];
    payoutAmount = json['payoutAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contestId'] = this.contestId;
    data['npnl'] = this.npnl;
    data['portfolioValue'] = this.portfolioValue;
    data['payoutAmount'] = this.payoutAmount;
    return data;
  }
}
