class StocksExcuatedOrderResponse {
  String? status;
  List<StocksExcuatedOrderData>? data;
  int? count;

  StocksExcuatedOrderResponse({this.status, this.data, this.count});

  StocksExcuatedOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StocksExcuatedOrderData>[];
      json['data'].forEach((v) {
        data!.add(new StocksExcuatedOrderData.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class StocksExcuatedOrderData {
  String? sId;
  String? type;
  String? status;
  num? executionPrice;
  num? price;
  int? quantity;
  String? buyOrSell;
  String? symbol;
  String? executionTime;
  num? amount;
  String? time;

  StocksExcuatedOrderData(
      {this.sId,
      this.type,
      this.status,
      this.executionPrice,
      this.price,
      this.quantity,
      this.buyOrSell,
      this.symbol,
      this.executionTime,
      this.amount,
      this.time});

  StocksExcuatedOrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    status = json['status'];
    executionPrice = json['execution_price'];
    price = json['price'];
    quantity = json['Quantity'];
    buyOrSell = json['buyOrSell'];
    symbol = json['symbol'];
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
    data['execution_time'] = this.executionTime;
    data['amount'] = this.amount;
    data['time'] = this.time;
    return data;
  }
}
