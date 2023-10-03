class InternshipPositionResponse {
  String? message;
  List<InternshipPosition>? data;

  InternshipPositionResponse({this.message, this.data});

  InternshipPositionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <InternshipPosition>[];
      json['data'].forEach((v) {
        data!.add(new InternshipPosition.fromJson(v));
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

class InternshipPosition {
  InternshipId? id;
  num? amount;
  num? brokerage;
  int? lots;
  num? lastaverageprice;

  InternshipPosition({
    this.id,
    this.amount,
    this.brokerage,
    this.lots,
    this.lastaverageprice,
  });

  InternshipPosition.fromJson(Map<String, dynamic> json) {
    id = json['_id'] != null ? new InternshipId.fromJson(json['_id']) : null;
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

class InternshipId {
  String? symbol;
  String? product;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? exchange;

  InternshipId({this.symbol, this.product, this.instrumentToken, this.exchangeInstrumentToken, this.exchange});

  InternshipId.fromJson(Map<String, dynamic> json) {
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
