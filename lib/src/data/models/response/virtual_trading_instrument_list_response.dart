class VirtualTradingInstrumentListResponse {
  List<VirtualTradingInstrument>? data;

  VirtualTradingInstrumentListResponse({this.data});

  VirtualTradingInstrumentListResponse.fromJson(List? json) {
    if (json != null) {
      data = <VirtualTradingInstrument>[];
      data = json.map((data) => VirtualTradingInstrument.fromJson(data)).toList();
    }
  }
}

class VirtualTradingInstrument {
  String? sId;
  int? instrumentToken;
  int? exchangeToken;
  String? tradingsymbol;
  String? name;
  int? lastPrice;
  String? expiry;
  int? strike;
  double? tickSize;
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
  int? iV;
  bool? earlySubscription;
  bool? infinityVisibility;

  VirtualTradingInstrument(
      {this.sId,
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
      this.iV,
      this.earlySubscription,
      this.infinityVisibility});

  VirtualTradingInstrument.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    iV = json['__v'];
    earlySubscription = json['earlySubscription'];
    infinityVisibility = json['infinityVisibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
    data['__v'] = this.iV;
    data['earlySubscription'] = this.earlySubscription;
    data['infinityVisibility'] = this.infinityVisibility;
    return data;
  }
}
