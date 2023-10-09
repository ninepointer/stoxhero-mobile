class TradingInstrumentTradeDetailsListResponse {
  List<TradingInstrumentTradeDetails>? data;

  TradingInstrumentTradeDetailsListResponse({this.data});

  TradingInstrumentTradeDetailsListResponse.fromJson(List? json) {
    if (json != null) {
      data = <TradingInstrumentTradeDetails>[];
      data = json.map((data) => TradingInstrumentTradeDetails.fromJson(data)).toList();
    }
  }
}

class TradingInstrumentTradeDetails {
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

  TradingInstrumentTradeDetails(
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

  TradingInstrumentTradeDetails.fromJson(Map<String, dynamic> json) {
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

class Ohlc {
  num? open;
  num? high;
  num? low;
  num? close;

  Ohlc({this.open, this.high, this.low, this.close});

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

class Depth {
  List<Buy>? buy;
  List<Sell>? sell;

  Depth({this.buy, this.sell});

  Depth.fromJson(Map<String, dynamic> json) {
    if (json['buy'] != null) {
      buy = <Buy>[];
      json['buy'].forEach((v) {
        buy!.add(new Buy.fromJson(v));
      });
    }
    if (json['sell'] != null) {
      sell = <Sell>[];
      json['sell'].forEach((v) {
        sell!.add(new Sell.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.buy != null) {
      data['buy'] = this.buy!.map((v) => v.toJson()).toList();
    }
    if (this.sell != null) {
      data['sell'] = this.sell!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buy {
  int? quantity;
  num? price;
  int? orders;

  Buy({this.quantity, this.price, this.orders});

  Buy.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['orders'] = this.orders;
    return data;
  }
}

class Sell {
  int? quantity;
  num? price;
  int? orders;

  Sell({this.quantity, this.price, this.orders});

  Sell.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    orders = json['orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['orders'] = this.orders;
    return data;
  }
}
