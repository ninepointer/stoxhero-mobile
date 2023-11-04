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
  num? price;
  int? quantity;
  String? buyOrSell;
  String? symbol;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? executionTime;
  num? amount;
  String? time;

  StopLossPendingOrdersList({
    this.id,
    this.type,
    this.status,
    this.price,
    this.quantity,
    this.buyOrSell,
    this.symbol,
    this.instrumentToken,
    this.exchangeInstrumentToken,
    this.executionTime,
    this.amount,
    this.time,
  });

  StopLossPendingOrdersList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    status = json['status'];
    price = json['price'];
    quantity = json['Quantity'];
    buyOrSell = json['buyOrSell'];
    symbol = json['symbol'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    executionTime = json['execution_time'];
    amount = json['amount'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['price'] = this.price;
    data['Quantity'] = this.quantity;
    data['buyOrSell'] = this.buyOrSell;
    data['symbol'] = this.symbol;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['execution_time'] = this.executionTime;
    data['amount'] = this.amount;
    data['time'] = this.time;
    return data;
  }
}
