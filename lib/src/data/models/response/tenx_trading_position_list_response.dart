class TradingPositionListResponse {
  String? message;
  List<TradingPosition>? data;

  TradingPositionListResponse({this.message, this.data});

  TradingPositionListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <TradingPosition>[];
      json['data'].forEach((v) {
        data!.add(new TradingPosition.fromJson(v));
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

class TradingPosition {
  IdDetails? id;
  num? amount;
  num? brokerage;
  int? lots;
  num? lastaverageprice;
  num? margin;

  TradingPosition({this.id, this.amount, this.brokerage, this.lots, this.lastaverageprice, this.margin});

  TradingPosition.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? new IdDetails.fromJson(json['_id']) : null;
    amount = json['amount'];
    brokerage = json['brokerage'];
    lots = json['lots'];
    lastaverageprice = json['lastaverageprice'];
    margin = json['margin'];
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
    data['margin'] = this.margin;
    return data;
  }
}

class IdDetails {
  String? symbol;
  String? product;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? exchange;
  String? validity;
  String? variety;
  bool? isLimit;

  IdDetails({
    this.symbol,
    this.product,
    this.instrumentToken,
    this.exchangeInstrumentToken,
    this.exchange,
    this.validity,
    this.variety,
    this.isLimit,
  });

  IdDetails.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    product = json['product'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    exchange = json['exchange'];
    validity = json['validity'];
    variety = json['variety'];
    isLimit = json['isLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['product'] = this.product;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['exchange'] = this.exchange;
    data['validity'] = this.validity;
    data['variety'] = this.variety;
    data['isLimit'] = this.isLimit;
    return data;
  }
}
