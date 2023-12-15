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

  IndexLivePrice(
      {this.lastPrice,
      this.instrumentToken,
      this.averagePrice,
      this.timestamp,
      this.change});

  IndexLivePrice.fromJson(Map<String, dynamic> json) {
    lastPrice = json['last_price'];
    instrumentToken = json['instrument_token'];
    averagePrice = json['average_price'];
    timestamp = json['timestamp'];
    change = json['change'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['last_price'] = this.lastPrice;
    data['instrument_token'] = this.instrumentToken;
    data['average_price'] = this.averagePrice;
    data['timestamp'] = this.timestamp;
    data['change'] = this.change;
    return data;
  }
}
