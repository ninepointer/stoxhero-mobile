class MarginXTradingPositionResponse {
  String? message;
  List<MarginXTradingPosition>? data;

  MarginXTradingPositionResponse({this.message, this.data});

  MarginXTradingPositionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <MarginXTradingPosition>[];
      json['data'].forEach((v) {
        data!.add(new MarginXTradingPosition.fromJson(v));
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

class MarginXTradingPosition {
  Mid? id;
  num? amount;
  num? brokerage;
  int? lots;
  num? lastaverageprice;

  MarginXTradingPosition({this.id, this.amount, this.brokerage, this.lots, this.lastaverageprice});

  MarginXTradingPosition.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? new Mid.fromJson(json['_id']) : null;
    amount = json['amount'];
    brokerage = json['brokerage'];
    lots = json['lots'];
    lastaverageprice = json['lastaverageprice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['_id'] = this.id!.toJson();
    }
    data['amount'] = this.amount;
    data['brokerage'] = this.brokerage;
    data['lots'] = this.lots;
    data['lastaverageprice'] = this.lastaverageprice;
    return data;
  }
}

class Mid {
  String? symbol;
  String? product;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? exchange;

  Mid({
    this.symbol,
    this.product,
    this.instrumentToken,
    this.exchangeInstrumentToken,
    this.exchange,
  });

  Mid.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    product = json['product'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    exchange = json['exchange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['product'] = this.product;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['exchange'] = this.exchange;
    return data;
  }
}
