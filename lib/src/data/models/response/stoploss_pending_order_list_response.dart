class StopLossPendingOrdersListResponse {
  String? status;
  List<StopLossPendingOrdersList>? data;

  StopLossPendingOrdersListResponse({this.status, this.data});

  StopLossPendingOrdersListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StopLossPendingOrdersList>[];
      json['data'].forEach((v) {
        data!.add(new StopLossPendingOrdersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StopLossPendingOrdersList {
  String? id;
  String? type;
  String? status;
  num? executionPrice;
  int? quantity;
  String? buyOrSell;
  String? symbol;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  num? amount;
  String? time;

  StopLossPendingOrdersList(
      {this.id,
      this.type,
      this.status,
      this.executionPrice,
      this.quantity,
      this.buyOrSell,
      this.symbol,
      this.instrumentToken,
      this.exchangeInstrumentToken,
      this.amount,
      this.time});

  StopLossPendingOrdersList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    status = json['status'];
    executionPrice = json['execution_price'];
    quantity = json['Quantity'];
    buyOrSell = json['buyOrSell'];
    symbol = json['symbol'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    amount = json['amount'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['execution_price'] = this.executionPrice;
    data['Quantity'] = this.quantity;
    data['buyOrSell'] = this.buyOrSell;
    data['symbol'] = this.symbol;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['amount'] = this.amount;
    data['time'] = this.time;
    return data;
  }
}
