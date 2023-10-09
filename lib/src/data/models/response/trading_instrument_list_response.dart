class TradingInstrumentListResponse {
  List<TradingInstrument>? data;

  TradingInstrumentListResponse({this.data});

  TradingInstrumentListResponse.fromJson(List? json) {
    if (json != null) {
      data = <TradingInstrument>[];
      data = json.map((data) => TradingInstrument.fromJson(data)).toList();
    }
  }
}

class TradingInstrument {
  String? id;
  int? instrumentToken;
  int? exchangeToken;
  String? tradingsymbol;
  String? name;
  num? lastPrice;
  String? expiry;
  int? strike;
  num? tickSize;
  int? lotSize;
  String? instrumentType;
  String? segment;
  String? exchange;
  String? lastModifiedBy;
  String? createdBy;
  String? status;
  String? chartInstrument;
  String? lastModifiedOn;
  String? createdOn;
  bool? earlySubscription;

  TradingInstrument(
      {this.id,
      this.instrumentToken,
      this.exchangeToken,
      this.tradingsymbol,
      this.name,
      this.lastPrice,
      this.expiry,
      this.strike,
      this.tickSize,
      this.lotSize,
      this.instrumentType,
      this.segment,
      this.exchange,
      this.lastModifiedBy,
      this.createdBy,
      this.status,
      this.chartInstrument,
      this.lastModifiedOn,
      this.createdOn,
      this.earlySubscription});

  TradingInstrument.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    instrumentToken = json['instrument_token'];
    exchangeToken = json['exchange_token'];
    tradingsymbol = json['tradingsymbol'];
    name = json['name'];
    lastPrice = json['last_price'];
    expiry = json['expiry'];
    strike = json['strike'];
    tickSize = json['tick_size'];
    lotSize = json['lot_size'];
    instrumentType = json['instrument_type'];
    segment = json['segment'];
    exchange = json['exchange'];
    lastModifiedBy = json['lastModifiedBy'];
    createdBy = json['createdBy'];
    status = json['status'];
    chartInstrument = json['chartInstrument'];
    lastModifiedOn = json['lastModifiedOn'];
    createdOn = json['createdOn'];
    earlySubscription = json['earlySubscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['instrument_token'] = this.instrumentToken;
    data['exchange_token'] = this.exchangeToken;
    data['tradingsymbol'] = this.tradingsymbol;
    data['name'] = this.name;
    data['last_price'] = this.lastPrice;
    data['expiry'] = this.expiry;
    data['strike'] = this.strike;
    data['tick_size'] = this.tickSize;
    data['lot_size'] = this.lotSize;
    data['instrument_type'] = this.instrumentType;
    data['segment'] = this.segment;
    data['exchange'] = this.exchange;
    data['lastModifiedBy'] = this.lastModifiedBy;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['chartInstrument'] = this.chartInstrument;
    data['lastModifiedOn'] = this.lastModifiedOn;
    data['createdOn'] = this.createdOn;
    data['earlySubscription'] = this.earlySubscription;
    return data;
  }
}
