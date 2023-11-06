class StopLossPendingCancelOrderResponse {
  String? status;
  StopLossPendingCancelOrder? data;

  StopLossPendingCancelOrderResponse({this.status, this.data});

  StopLossPendingCancelOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new StopLossPendingCancelOrder.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class StopLossPendingCancelOrder {
  String? id;
  String? orderReferanceId;
  String? productType;
  String? type;
  String? status;
  int? executionPrice;
  double? lastPrice;
  int? quantity;
  String? product;
  String? buyOrSell;
  String? variety;
  String? validity;
  String? exchange;
  String? orderType;
  String? symbol;
  int? instrumentToken;
  int? exchangeInstrumentToken;
  String? executionTime;
  String? createdBy;
  String? subProductId;
  String? createdOn;
  int? iV;

  StopLossPendingCancelOrder(
      {this.id,
      this.orderReferanceId,
      this.productType,
      this.type,
      this.status,
      this.executionPrice,
      this.lastPrice,
      this.quantity,
      this.product,
      this.buyOrSell,
      this.variety,
      this.validity,
      this.exchange,
      this.orderType,
      this.symbol,
      this.instrumentToken,
      this.exchangeInstrumentToken,
      this.executionTime,
      this.createdBy,
      this.subProductId,
      this.createdOn,
      this.iV});

  StopLossPendingCancelOrder.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    orderReferanceId = json['order_referance_id'];
    productType = json['product_type'];
    type = json['type'];
    status = json['status'];
    executionPrice = json['execution_price'];
    lastPrice = json['last_price'];
    quantity = json['Quantity'];
    product = json['Product'];
    buyOrSell = json['buyOrSell'];
    variety = json['variety'];
    validity = json['validity'];
    exchange = json['exchange'];
    orderType = json['order_type'];
    symbol = json['symbol'];
    instrumentToken = json['instrumentToken'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    executionTime = json['execution_time'];
    createdBy = json['createdBy'];
    subProductId = json['sub_product_id'];
    createdOn = json['createdOn'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['order_referance_id'] = this.orderReferanceId;
    data['product_type'] = this.productType;
    data['type'] = this.type;
    data['status'] = this.status;
    data['execution_price'] = this.executionPrice;
    data['last_price'] = this.lastPrice;
    data['Quantity'] = this.quantity;
    data['Product'] = this.product;
    data['buyOrSell'] = this.buyOrSell;
    data['variety'] = this.variety;
    data['validity'] = this.validity;
    data['exchange'] = this.exchange;
    data['order_type'] = this.orderType;
    data['symbol'] = this.symbol;
    data['instrumentToken'] = this.instrumentToken;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['execution_time'] = this.executionTime;
    data['createdBy'] = this.createdBy;
    data['sub_product_id'] = this.subProductId;
    data['createdOn'] = this.createdOn;
    data['__v'] = this.iV;
    return data;
  }
}
