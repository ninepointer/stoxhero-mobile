class AddInstrumentRequest {
  String? instrument;
  String? exchange;
  String? status;
  String? symbol;
  int? lotSize;
  int? instrumentToken;
  String? uId;
  String? contractDate;
  int? maxLot;
  String? from;
  String? chartInstrument;
  String? exchangeSegment;
  int? exchangeInstrumentToken;

  AddInstrumentRequest({
    this.instrument,
    this.exchange,
    this.status,
    this.symbol,
    this.lotSize,
    this.instrumentToken,
    this.uId,
    this.contractDate,
    this.maxLot,
    this.from,
    this.chartInstrument,
    this.exchangeSegment,
    this.exchangeInstrumentToken,
  });

  AddInstrumentRequest.fromJson(Map<String, dynamic> json) {
    instrument = json['instrument'];
    exchange = json['exchange'];
    status = json['status'];
    symbol = json['symbol'];
    lotSize = json['lotSize'];
    instrumentToken = json['instrumentToken'];
    uId = json['uId'];
    contractDate = json['contractDate'];
    maxLot = json['maxLot'];
    from = json['from'];
    chartInstrument = json['chartInstrument'];
    exchangeSegment = json['exchangeSegment'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instrument'] = this.instrument;
    data['exchange'] = this.exchange;
    data['status'] = this.status;
    data['symbol'] = this.symbol;
    data['lotSize'] = this.lotSize;
    data['instrumentToken'] = this.instrumentToken;
    data['uId'] = this.uId;
    data['contractDate'] = this.contractDate;
    data['maxLot'] = this.maxLot;
    data['from'] = this.from;
    data['chartInstrument'] = this.chartInstrument;
    data['exchangeSegment'] = this.exchangeSegment;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    return data;
  }
}
