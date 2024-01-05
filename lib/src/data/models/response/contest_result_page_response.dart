class ContestResultPageResponse {
  String? status;
  String? message;
  ResultPageData? data;

  ContestResultPageResponse({this.status, this.message, this.data});

  ContestResultPageResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new ResultPageData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResultPageData {
  num? npnl;
  String? user;
  int? rank;

  ResultPageData({this.npnl, this.user, this.rank});

  ResultPageData.fromJson(Map<String, dynamic> json) {
    npnl = json['npnl'];
    user = json['user'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['npnl'] = this.npnl;
    data['user'] = this.user;
    data['rank'] = this.rank;
    return data;
  }
}
