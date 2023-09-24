class StockIndexInstrumentDetailsListResponse {
  List<StockIndexInstrumentDetailsList>? data;

  StockIndexInstrumentDetailsListResponse({this.data});

  StockIndexInstrumentDetailsListResponse.fromJson(List? json) {
    if (json != null) {
      data = <StockIndexInstrumentDetailsList>[];
      data = json.map((data) => StockIndexInstrumentDetailsList.fromJson(data)).toList();
    }
  }
}

class StockIndexInstrumentDetailsList {
  bool? tradable;
  String? mode;
  int? instrumentToken;
  num? lastPrice;
  SOhlc? ohlc;
  num? change;
  String? exchangeTimestamp;

  StockIndexInstrumentDetailsList({
    this.tradable,
    this.mode,
    this.instrumentToken,
    this.lastPrice,
    this.ohlc,
    this.change,
    this.exchangeTimestamp,
  });

  StockIndexInstrumentDetailsList.fromJson(Map<String, dynamic> json) {
    tradable = json['tradable'];
    mode = json['mode'];
    instrumentToken = json['instrument_token'];
    lastPrice = json['last_price'];
    ohlc = json['ohlc'] != null ? new SOhlc.fromJson(json['ohlc']) : null;
    change = json['change'];
    exchangeTimestamp = json['exchange_timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tradable'] = this.tradable;
    data['mode'] = this.mode;
    data['instrument_token'] = this.instrumentToken;
    data['last_price'] = this.lastPrice;
    if (this.ohlc != null) {
      data['ohlc'] = this.ohlc!.toJson();
    }
    data['change'] = this.change;
    data['exchange_timestamp'] = this.exchangeTimestamp;
    return data;
  }
}

class SOhlc {
  num? high;
  num? low;
  num? open;
  num? close;

  SOhlc({this.high, this.low, this.open, this.close});

  SOhlc.fromJson(Map<String, dynamic> json) {
    high = json['high'];
    low = json['low'];
    open = json['open'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['high'] = this.high;
    data['low'] = this.low;
    data['open'] = this.open;
    data['close'] = this.close;
    return data;
  }
}
