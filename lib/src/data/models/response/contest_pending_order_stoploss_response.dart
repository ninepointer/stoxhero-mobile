class ContestStopLossPendingOrderResponse {
  String? status;
  List<ContestPendingStoplossOrderData>? data;
  int? count;
  List<ContestStoplossQuantityData>? quantity;

  ContestStopLossPendingOrderResponse(
      {this.status, this.data, this.count, this.quantity});

  ContestStopLossPendingOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ContestPendingStoplossOrderData>[];
      json['data'].forEach((v) {
        data!.add(new ContestPendingStoplossOrderData.fromJson(v));
      });
    }
    count = json['count'];
    if (json['quantity'] != null) {
      quantity = <ContestStoplossQuantityData>[];
      json['quantity'].forEach((v) {
        quantity!.add(new ContestStoplossQuantityData.fromJson(v));
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

class ContestPendingStoplossOrderData {
  String? sId;
  String? type;
  String? status;
  num? executionPrice;
  num? price;
  int? quantity;
  String? buyOrSell;
  String? symbol;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? executionTime;
  num? amount;
  String? time;

  ContestPendingStoplossOrderData(
      {this.sId,
      this.type,
      this.status,
      this.executionPrice,
      this.price,
      this.quantity,
      this.buyOrSell,
      this.symbol,
      this.instrumentToken,
      this.exchangeInstrumentToken,
      this.executionTime,
      this.amount,
      this.time});

  ContestPendingStoplossOrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    status = json['status'];
    executionPrice = json['execution_price'];
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
    data['execution_price'] = this.executionPrice;
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

class ContestStoplossQuantityData {
  String? type;
  int? quantity;
  String? symbol;

  ContestStoplossQuantityData({this.type, this.quantity, this.symbol});

  ContestStoplossQuantityData.fromJson(Map<String, dynamic> json) {
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
