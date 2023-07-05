class TenxTradingInstrumentTradeDetailsListResponse {
  List<TenxTradingInstrumentTradeDetails>? data;

  TenxTradingInstrumentTradeDetailsListResponse({this.data});

  TenxTradingInstrumentTradeDetailsListResponse.fromJson(List? json) {
    if (json != null) {
      data = <TenxTradingInstrumentTradeDetails>[];
      data = json.map((data) => TenxTradingInstrumentTradeDetails.fromJson(data)).toList();
    }
  }
}

class TenxTradingInstrumentTradeDetails {
  bool? tradable;
  String? mode;
  int? instrumentToken;
  num? lastPrice;
  int? lastTradedQuantity;
  num? averageTradedPrice;
  int? volumeTraded;
  int? totalBuyQuantity;
  int? totalSellQuantity;
  num? change;
  Ohlc? ohlc;

  TenxTradingInstrumentTradeDetails({
    this.tradable,
    this.mode,
    this.instrumentToken,
    this.lastPrice,
    this.lastTradedQuantity,
    this.averageTradedPrice,
    this.volumeTraded,
    this.totalBuyQuantity,
    this.totalSellQuantity,
    this.change,
    this.ohlc,
  });

  TenxTradingInstrumentTradeDetails.fromJson(Map<String, dynamic> json) {
    tradable = json['tradable'];
    mode = json['mode'];
    instrumentToken = json['instrument_token'];
    lastPrice = json['last_price'];
    lastTradedQuantity = json['last_traded_quantity'];
    averageTradedPrice = json['average_traded_price'];
    volumeTraded = json['volume_traded'];
    totalBuyQuantity = json['total_buy_quantity'];
    totalSellQuantity = json['total_sell_quantity'];
    change = json['change'];
    ohlc = json['ohlc'] != null ? new Ohlc.fromJson(json['ohlc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tradable'] = this.tradable;
    data['mode'] = this.mode;
    data['instrument_token'] = this.instrumentToken;
    data['last_price'] = this.lastPrice;
    data['last_traded_quantity'] = this.lastTradedQuantity;
    data['average_traded_price'] = this.averageTradedPrice;
    data['volume_traded'] = this.volumeTraded;
    data['total_buy_quantity'] = this.totalBuyQuantity;
    data['total_sell_quantity'] = this.totalSellQuantity;
    data['change'] = this.change;
    if (this.ohlc != null) {
      data['ohlc'] = this.ohlc!.toJson();
    }
    return data;
  }
}

class Ohlc {
  num? open;
  num? high;
  num? low;
  num? close;

  Ohlc({
    this.open,
    this.high,
    this.low,
    this.close,
  });

  Ohlc.fromJson(Map<String, dynamic> json) {
    open = json['open'];
    high = json['high'];
    low = json['low'];
    close = json['close'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open'] = this.open;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    return data;
  }
}
