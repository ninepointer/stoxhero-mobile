import '../../../app/app.dart';

class StockPendingOrderModifyRequest {
  String? exchange;
  String? symbol;
  String? buyOrSell;
  int? quantity;
  int? stopLossQuantity;
  int? stopProfitQuantity;
  String? id;
  String? product;
  String? orderType;
  String? stopProfitPrice;
  String? stopLossPrice;
  int? exchangeInstrumentToken;
  String? validity;
  String? variety;
  int? instrumentToken;
  String? lastPrice;
  String? stock;
  DeviceDetails? deviceDetails;

  StockPendingOrderModifyRequest({
    this.exchange,
    this.symbol,
    this.buyOrSell,
    this.quantity,
    this.stopLossQuantity,
    this.stopProfitQuantity,
    this.id,
    this.product,
    this.orderType,
    this.stopProfitPrice,
    this.stopLossPrice,
    this.exchangeInstrumentToken,
    this.validity,
    this.variety,
    this.instrumentToken,
    this.lastPrice,
    this.stock,
    this.deviceDetails,
  });

  StockPendingOrderModifyRequest.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symbol = json['symbol'];
    buyOrSell = json['buyOrSell'];
    quantity = json['Quantity'];
    stopLossQuantity = json['stopLossQuantity'];
    stopLossQuantity = json['stopProfitQuantity'];
    id = json['id'];
    product = json['Product'];
    orderType = json['order_type'];
    stopProfitPrice = json['stopProfitPrice'];
    stopLossPrice = json['stopLossPrice'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    validity = json['validity'];
    variety = json['variety'];
    instrumentToken = json['instrumentToken'];
    lastPrice = json['last_price'];
    stock = json['from'];
    deviceDetails = json['deviceDetails'] != null
        ? new DeviceDetails.fromJson(json['deviceDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['buyOrSell'] = this.buyOrSell;
    data['Quantity'] = this.quantity;
    data['stopLossQuantity'] = this.stopLossQuantity;
    data['stopProfitQuantity'] = this.stopProfitQuantity;
    data['id'] = this.id;
    data['Product'] = this.product;
    data['order_type'] = this.orderType;
    data['stopProfitPrice'] = this.stopProfitPrice;
    data['stopLossPrice'] = this.stopLossPrice;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['validity'] = this.validity;
    data['variety'] = this.variety;
    data['instrumentToken'] = this.instrumentToken;
    data['last_price'] = this.lastPrice;
    data['from'] = this.stock;
    if (this.deviceDetails != null) {
      data['deviceDetails'] = this.deviceDetails!.toJson();
    }
    return data;
  }
}
