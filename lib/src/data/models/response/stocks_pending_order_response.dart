class StocksPendingOrderResponse {
  String? status;
  List<StocksPendingOrderData>? data;
  int? count;
  List<Quantity>? quantity;

  StocksPendingOrderResponse(
      {this.status, this.data, this.count, this.quantity});

  StocksPendingOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StocksPendingOrderData>[];
      json['data'].forEach((v) {
        data!.add(new StocksPendingOrderData.fromJson(v));
      });
    }
    count = json['count'];
    if (json['quantity'] != null) {
      quantity = <Quantity>[];
      json['quantity'].forEach((v) {
        quantity!.add(new Quantity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    if (this.quantity != null) {
      data['quantity'] = this.quantity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StocksPendingOrderData {
  String? sId;
  String? type;
  String? status;
  int? price;
  int? quantity;
  String? buyOrSell;
  String? symbol;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? executionTime;
  int? amount;
  String? time;

  StocksPendingOrderData(
      {this.sId,
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
      this.time});

  StocksPendingOrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    data['_id'] = this.sId;
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

class Quantity {
  String? type;
  int? quantity;
  String? symbol;

  Quantity({this.type, this.quantity, this.symbol});

  Quantity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    quantity = json['quantity'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['quantity'] = this.quantity;
    data['symbol'] = this.symbol;
    return data;
  }
}
