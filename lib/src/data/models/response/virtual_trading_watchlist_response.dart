class VirtualTradingWatchListResponse {
  String? message;
  List<VirtualTradingWatchList>? data;

  VirtualTradingWatchListResponse({this.message, this.data});

  VirtualTradingWatchListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <VirtualTradingWatchList>[];
      json['data'].forEach((v) {
        data!.add(new VirtualTradingWatchList.fromJson(v));
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

class VirtualTradingWatchList {
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
  String? chartInstrument;

  VirtualTradingWatchList(
      {this.sId,
      this.instrument,
      this.exchange,
      this.symbol,
      this.status,
      this.lotSize,
      this.instrumentToken,
      this.exchangeInstrumentToken,
      this.contractDate,
      this.maxLot,
      this.chartInstrument});

  VirtualTradingWatchList.fromJson(Map<String, dynamic> json) {
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
    chartInstrument = json['chartInstrument'];
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
    data['chartInstrument'] = this.chartInstrument;
    return data;
  }
}
