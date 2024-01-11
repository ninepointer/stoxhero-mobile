class StockPlaceOrderRequest {
  String? product;
  int? quantity;
  String? triggerPrice;
  String? buyOrSell;
  String? exchange;
  int? exchangeInstrumentToken;
  int? instrumentToken;
  String? orderType;
  double? price;
  String? stopLoss;
  String? stopLossPrice;
  String? stopProfitPrice;
  String? symbol;
  String? validity;
  String? variety;

  StockPlaceOrderRequest({
    this.product,
    this.quantity,
    this.triggerPrice,
    this.buyOrSell,
    this.exchange,
    this.exchangeInstrumentToken,
    this.instrumentToken,
    this.orderType,
    this.price,
    this.stopLoss,
    this.stopLossPrice,
    this.stopProfitPrice,
    this.symbol,
    this.validity,
    this.variety,
  });

  StockPlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    product = json['Product'];
    quantity = json['Quantity'];
    triggerPrice = json['TriggerPrice'];
    buyOrSell = json['buyOrSell'];
    exchange = json['exchange'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    instrumentToken = json['instrumentToken'];
    orderType = json['order_type'];
    price = json['price'];
    stopLoss = json['stopLoss'];
    stopLossPrice = json['stopLossPrice'];
    stopProfitPrice = json['stopProfitPrice'];
    symbol = json['symbol'];
    validity = json['validity'];
    variety = json['variety'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Product'] = this.product;
    data['Quantity'] = this.quantity;
    data['TriggerPrice'] = this.triggerPrice;
    data['buyOrSell'] = this.buyOrSell;
    data['exchange'] = this.exchange;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['instrumentToken'] = this.instrumentToken;
    data['order_type'] = this.orderType;
    data['price'] = this.price;
    data['stopLoss'] = this.stopLoss;
    data['stopLossPrice'] = this.stopLossPrice;
    data['stopProfitPrice'] = this.stopProfitPrice;
    data['symbol'] = this.symbol;
    data['validity'] = this.validity;
    data['variety'] = this.variety;
    return data;
  }
}
