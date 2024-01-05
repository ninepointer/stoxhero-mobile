class InstrumentLivePriceListResponse {
  List<InstrumentLivePrice>? data;

  InstrumentLivePriceListResponse({this.data});

  InstrumentLivePriceListResponse.fromJson(List? json) {
    if (json != null) {
      data = <InstrumentLivePrice>[];
      data = json.map((data) => InstrumentLivePrice.fromJson(data)).toList();
    }
  }
}

class InstrumentLivePrice {
  int? instrumentToken;
  num? lastPrice;
  num? averagePrice;
  String? timestamp;
  num? change;
  InstrumentLivePrice({
    this.instrumentToken,
    this.lastPrice,
    this.averagePrice,
    this.timestamp,
    this.change,
  });

  InstrumentLivePrice.fromJson(Map<String, dynamic> json) {
    instrumentToken = json['instrument_token'];
    lastPrice = json['last_price'];
    averagePrice = json['average_price'];
    timestamp = json['timestamp'];
    change = json['change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instrument_token'] = this.instrumentToken;
    data['last_price'] = this.lastPrice;
    data['average_price'] = this.averagePrice;
    data['timestamp'] = this.timestamp;
    data['change'] = this.change;
    return data;
  }
}
