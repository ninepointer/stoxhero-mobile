class EquityInstrumentDetailsResponse {
  String? status;
  String? message;
  List<EquityInstrumentDetail>? data;

  EquityInstrumentDetailsResponse({this.status, this.message, this.data});

  EquityInstrumentDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <EquityInstrumentDetail>[];
      json['data'].forEach((v) {
        data!.add(new EquityInstrumentDetail.fromJson(v));
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

class EquityInstrumentDetail {
  String? sId;
  String? exchange;
  String? symbol;
  String? status;
  int? instrumentToken;
  int? exchangeInstrumentToken;

  EquityInstrumentDetail(
      {this.sId,
      this.exchange,
      this.symbol,
      this.status,
      this.instrumentToken,
      this.exchangeInstrumentToken});

  EquityInstrumentDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    exchange = json['exchange'];
    symbol = json['symbol'];
    status = json['status'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['status'] = this.status;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    return data;
  }
}
