class CompletedMarginxListResponse {
  String? status;
  List<CompletedMarginx>? data;

  CompletedMarginxListResponse({this.status, this.data});

  CompletedMarginxListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CompletedMarginx>[];
      json['data'].forEach((v) {
        data!.add(new CompletedMarginx.fromJson(v));
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

class CompletedMarginx {
  String? marginxId;
  num? npnl;
  int? portfolioValue;
  int? entryFee;
  String? startTime;
  String? endTime;
  String? marginxName;
  bool? isNifty;
  bool? isBankNifty;
  bool? isFinNifty;
  String? marginxExpiry;
  int? maxParticipants;
  num? earning;

  CompletedMarginx({
    this.marginxId,
    this.npnl,
    this.portfolioValue,
    this.entryFee,
    this.startTime,
    this.endTime,
    this.marginxName,
    this.isNifty,
    this.isBankNifty,
    this.isFinNifty,
    this.marginxExpiry,
    this.maxParticipants,
    this.earning,
  });

  CompletedMarginx.fromJson(Map<String, dynamic> json) {
    marginxId = json['marginxId'];
    npnl = json['npnl'];
    portfolioValue = json['portfolioValue'];
    entryFee = json['entryFee'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    marginxName = json['marginxName'];
    isNifty = json['isNifty'];
    isBankNifty = json['isBankNifty'];
    isFinNifty = json['isFinNifty'];
    marginxExpiry = json['marginxExpiry'];
    maxParticipants = json['maxParticipants'];
    earning = json['earning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marginxId'] = this.marginxId;
    data['npnl'] = this.npnl;
    data['portfolioValue'] = this.portfolioValue;
    data['entryFee'] = this.entryFee;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['marginxName'] = this.marginxName;
    data['isNifty'] = this.isNifty;
    data['isBankNifty'] = this.isBankNifty;
    data['isFinNifty'] = this.isFinNifty;
    data['marginxExpiry'] = this.marginxExpiry;
    data['maxParticipants'] = this.maxParticipants;
    data['earning'] = this.earning;
    return data;
  }
}
