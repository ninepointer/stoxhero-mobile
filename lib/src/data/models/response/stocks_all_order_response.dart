class StocksAllOrderResponse {
  String? status;
  List<StocksAllOrderData>? data;
  int? count;

  StocksAllOrderResponse({this.status, this.data, this.count});

  StocksAllOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StocksAllOrderData>[];
      json['data'].forEach((v) {
        data!.add(new StocksAllOrderData.fromJson(v));
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

class StocksAllOrderData {
  String? sId;
  String? orderId;
  String? status;
  num? averagePrice;
  int? quantity;
  String? product;
  String? buyOrSell;
  String? symbol;
  num? amount;
  String? tradeTime;

  StocksAllOrderData(
      {this.sId,
      this.orderId,
      this.status,
      this.averagePrice,
      this.quantity,
      this.product,
      this.buyOrSell,
      this.symbol,
      this.amount,
      this.tradeTime});

  StocksAllOrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['order_id'];
    status = json['status'];
    averagePrice = json['average_price'];
    quantity = json['Quantity'];
    product = json['Product'];
    buyOrSell = json['buyOrSell'];
    symbol = json['symbol'];
    amount = json['amount'];
    tradeTime = json['trade_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['average_price'] = this.averagePrice;
    data['Quantity'] = this.quantity;
    data['Product'] = this.product;
    data['buyOrSell'] = this.buyOrSell;
    data['symbol'] = this.symbol;
    data['amount'] = this.amount;
    data['trade_time'] = this.tradeTime;
    return data;
  }
}
