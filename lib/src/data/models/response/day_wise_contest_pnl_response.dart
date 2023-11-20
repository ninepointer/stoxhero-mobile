class DayWiseContestPnlResponse {
  String? status;
  List<DayWiseContestPnl>? data;

  DayWiseContestPnlResponse({this.status, this.data});

  DayWiseContestPnlResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DayWiseContestPnl>[];
      json['data'].forEach((v) {
        data!.add(new DayWiseContestPnl.fromJson(v));
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

class DayWiseContestPnl {
  num? gpnl;
  num? brokerage;
  int? trades;
  String? date;
  num? npnl;

  DayWiseContestPnl({this.gpnl, this.brokerage, this.trades, this.date, this.npnl});

  DayWiseContestPnl.fromJson(Map<String, dynamic> json) {
    gpnl = json['gpnl'];
    brokerage = json['brokerage'];
    trades = json['trades'];
    date = json['date'];
    npnl = json['npnl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gpnl'] = this.gpnl;
    data['brokerage'] = this.brokerage;
    data['trades'] = this.trades;
    data['date'] = this.date;
    data['npnl'] = this.npnl;
    return data;
  }
}
