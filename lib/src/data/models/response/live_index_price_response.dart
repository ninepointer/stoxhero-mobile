class IndexLivePriceListResponse {
  List<IndexLivePrice>? data;

  IndexLivePriceListResponse({this.data});

  IndexLivePriceListResponse.fromJson(List? json) {
    if (json != null) {
      data = <IndexLivePrice>[];
      data = json.map((data) => IndexLivePrice.fromJson(data)).toList();
    }
  }
}

class IndexLivePrice {
  num? lastPrice;
  num? instrumentToken;
  num? averagePrice;
  String? timestamp;
  num? change;
  SSOhlc? ohlc;

  IndexLivePrice({
    this.lastPrice,
    this.instrumentToken,
    this.averagePrice,
    this.timestamp,
    this.change,
    this.ohlc,
  });

  IndexLivePrice.fromJson(Map<String, dynamic> json) {
    lastPrice = json['last_price'];
    instrumentToken = json['instrument_token'];
    averagePrice = json['average_price'];
    timestamp = json['timestamp'];
    change = json['change'];
    ohlc = json['ohlc'] != null ? new SSOhlc.fromJson(json['ohlc']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_price'] = this.lastPrice;
    data['instrument_token'] = this.instrumentToken;
    data['average_price'] = this.averagePrice;
    data['timestamp'] = this.timestamp;
    data['change'] = this.change;
    if (this.ohlc != null) {
      data['ohlc'] = this.ohlc!.toJson();
    }
    return data;
  }
}

class SSOhlc {
  num? high;
  num? low;
  num? open;
  num? close;

  SSOhlc({this.high, this.low, this.open, this.close});

  SSOhlc.fromJson(Map<String, dynamic> json) {
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
