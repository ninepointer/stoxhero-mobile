class AddStockWathclistRequest {
  int? exchangeInstrumentToken;
  String? exchange;
  String? symbol;
  String? status;
  int? instrumentToken;
  String? accountType;
  String? name;

  AddStockWathclistRequest({
    this.exchangeInstrumentToken,
    this.exchange,
    this.symbol,
    this.status,
    this.instrumentToken,
    this.accountType,
    this.name,
  });

  AddStockWathclistRequest.fromJson(Map<String, dynamic> json) {
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    exchange = json['exchange'];
    symbol = json['symbol'];
    status = json['status'];
    instrumentToken = json['instrumentToken'];
    accountType = json['accountType'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['status'] = this.status;
    data['instrumentToken'] = this.instrumentToken;
    data['accountType'] = this.accountType;
    data['name'] = this.name;
    return data;
  }
}
