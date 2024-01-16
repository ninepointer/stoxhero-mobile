class MarginRequiredRequest {
  String? exchange;
  String? symbol;
  String? buyOrSell;
  int? quantity;
  String? product;
  String? orderType;
  String? validity;
  String? variety;
  String? price;
  String? lastPrice;

  MarginRequiredRequest(
      {this.exchange,
      this.symbol,
      this.buyOrSell,
      this.quantity,
      this.product,
      this.orderType,
      this.validity,
      this.variety,
      this.price,
      this.lastPrice
      });

  MarginRequiredRequest.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symbol = json['symbol'];
    buyOrSell = json['buyOrSell'];
    quantity = json['Quantity'];
    product = json['Product'];
    orderType = json['order_type'];
    validity = json['validity'];
    variety = json['variety'];
    price = json['price'];
    lastPrice = json['last_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['buyOrSell'] = this.buyOrSell;
    data['Quantity'] = this.quantity;
    data['Product'] = this.product;
    data['order_type'] = this.orderType;
    data['validity'] = this.validity;
    data['variety'] = this.variety;
    data['price'] = this.price;
    data['last_price'] = this.lastPrice;
    return data;
  }
}
