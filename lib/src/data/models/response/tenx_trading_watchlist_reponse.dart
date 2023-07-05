class TenxTradingWatchlistResponse {
  String? message;
  List<TenxTradingWatchlist>? data;

  TenxTradingWatchlistResponse({this.message, this.data});

  TenxTradingWatchlistResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TenxTradingWatchlist>[];
      json['data'].forEach((v) {
        data!.add(new TenxTradingWatchlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TenxTradingWatchlist {
  String? sId;
  String? instrument;
  String? exchange;
  String? symbol;
  String? status;
  int? lotSize;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? contractDate;
  int? maxLot;

  TenxTradingWatchlist(
      {this.sId,
      this.instrument,
      this.exchange,
      this.symbol,
      this.status,
      this.lotSize,
      this.instrumentToken,
      this.exchangeInstrumentToken,
      this.contractDate,
      this.maxLot});

  TenxTradingWatchlist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    instrument = json['instrument'];
    exchange = json['exchange'];
    symbol = json['symbol'];
    status = json['status'];
    lotSize = json['lotSize'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    contractDate = json['contractDate'];
    maxLot = json['maxLot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['instrument'] = this.instrument;
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['status'] = this.status;
    data['lotSize'] = this.lotSize;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['contractDate'] = this.contractDate;
    data['maxLot'] = this.maxLot;
    return data;
  }
}
