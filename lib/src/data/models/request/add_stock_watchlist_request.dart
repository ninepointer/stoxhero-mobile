class AddStockWathclistRequest {
  int? exchangeInstrumentToken;
  String? exchange;
  String? symbol;
  String? status;
  int? instrumentToken;

  AddStockWathclistRequest(
      {this.exchangeInstrumentToken,
      this.exchange,
      this.symbol,
      this.status,
      this.instrumentToken});

  AddStockWathclistRequest.fromJson(Map<String, dynamic> json) {
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    exchange = json['exchange'];
    symbol = json['symbol'];
    status = json['status'];
    instrumentToken = json['instrumentToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['status'] = this.status;
    data['instrumentToken'] = this.instrumentToken;
    return data;
  }
}
