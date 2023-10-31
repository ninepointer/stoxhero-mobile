import '../../../app/app.dart';

class VirtualTradingInstrumentTradeDetailsListResponse {
  List<VirtualTradingInstrumentTradeDetails>? data;

  VirtualTradingInstrumentTradeDetailsListResponse({this.data});

  VirtualTradingInstrumentTradeDetailsListResponse.fromJson(List? json) {
    if (json != null) {
      data = <VirtualTradingInstrumentTradeDetails>[];
      data = json.map((data) => VirtualTradingInstrumentTradeDetails.fromJson(data)).toList();
    }
  }
}

class VirtualTradingInstrumentTradeDetails {
  bool? tradable;
  String? mode;
  int? instrumentToken;
  num? lastPrice;
  int? lastTradedQuantity;
  num? averageTradedPrice;
  int? volumeTraded;
  int? totalBuyQuantity;
  int? totalSellQuantity;
  Ohlc? ohlc;
  num? change;
  String? lastTradeTime;
  String? exchangeTimestamp;
  int? oi;
  int? oiDayHigh;
  int? oiDayLow;
  Depth? depth;

  VirtualTradingInstrumentTradeDetails(
      {this.tradable,
      this.mode,
      this.instrumentToken,
      this.lastPrice,
      this.lastTradedQuantity,
      this.averageTradedPrice,
      this.volumeTraded,
      this.totalBuyQuantity,
      this.totalSellQuantity,
      this.ohlc,
      this.change,
      this.lastTradeTime,
      this.exchangeTimestamp,
      this.oi,
      this.oiDayHigh,
      this.oiDayLow,
      this.depth});

  VirtualTradingInstrumentTradeDetails.fromJson(Map<String, dynamic> json) {
    tradable = json['tradable'];
    mode = json['mode'];
    instrumentToken = json['instrument_token'];
    lastPrice = json['last_price'];
    lastTradedQuantity = json['last_traded_quantity'];
    averageTradedPrice = json['average_traded_price'];
    volumeTraded = json['volume_traded'];
    totalBuyQuantity = json['total_buy_quantity'];
    totalSellQuantity = json['total_sell_quantity'];
    ohlc = json['ohlc'] != null ? new Ohlc.fromJson(json['ohlc']) : null;
    change = json['change'];
    lastTradeTime = json['last_trade_time'];
    exchangeTimestamp = json['exchange_timestamp'];
    oi = json['oi'];
    oiDayHigh = json['oi_day_high'];
    oiDayLow = json['oi_day_low'];
    depth = json['depth'] != null ? new Depth.fromJson(json['depth']) : null;
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
    if (this.ohlc != null) {
      data['ohlc'] = this.ohlc!.toJson();
    }
    data['change'] = this.change;
    data['last_trade_time'] = this.lastTradeTime;
    data['exchange_timestamp'] = this.exchangeTimestamp;
    data['oi'] = this.oi;
    data['oi_day_high'] = this.oiDayHigh;
    data['oi_day_low'] = this.oiDayLow;
    if (this.depth != null) {
      data['depth'] = this.depth!.toJson();
    }
    return data;
  }
}
