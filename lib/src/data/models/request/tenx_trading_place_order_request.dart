import '../../../app/app.dart';

class TenxTradingPlaceOrderRequest {
  String? exchange;
  String? symbol;
  String? buyOrSell;
  int? quantity;
  String? price;
  String? battleId;
  String? product;
  String? orderType;
  String? triggerPrice;
  String? stopLoss;
  String? marginxId;
  String? validity;
  String? variety;
  String? orderId;
  String? subscriptionId;
  int? exchangeInstrumentToken;
  String? userId;
  int? instrumentToken;
  String? trader;
  bool? paperTrade;
  bool? tenxTraderPath;
  String? stopLossPrice;
  String? uId;
  String? createdBy;
  String? stopProfitPrice;
  DeviceDetails? deviceDetails;

  TenxTradingPlaceOrderRequest({
    this.exchange,
    this.symbol,
    this.buyOrSell,
    this.quantity,
    this.price,
    this.battleId,
    this.product,
    this.orderType,
    this.triggerPrice,
    this.stopLoss,
    this.marginxId,
    this.validity,
    this.variety,
    this.orderId,
    this.subscriptionId,
    this.exchangeInstrumentToken,
    this.userId,
    this.instrumentToken,
    this.trader,
    this.paperTrade,
    this.tenxTraderPath,
    this.stopLossPrice,
    this.uId,
    this.createdBy,
    this.stopProfitPrice,
    this.deviceDetails,
  });

  TenxTradingPlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symbol = json['symbol'];
    buyOrSell = json['buyOrSell'];
    quantity = json['Quantity'];
    price = json['price'];
    battleId = json['battleId'];
    product = json['Product'];
    orderType = json['order_type'];
    triggerPrice = json['TriggerPrice'];
    stopLoss = json['stopLoss'];
    marginxId = json['marginxId'];
    validity = json['validity'];
    variety = json['variety'];
    orderId = json['order_id'];
    subscriptionId = json['subscriptionId'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    userId = json['userId'];
    instrumentToken = json['instrumentToken'];
    trader = json['trader'];
    paperTrade = json['paperTrade'];
    tenxTraderPath = json['tenxTraderPath'];
    stopLossPrice = json['stopLossPrice'];
    uId = json['uId'];
    createdBy = json['createdBy'];
    stopProfitPrice = json['stopProfitPrice'];
    deviceDetails = json['deviceDetails'] != null ? new DeviceDetails.fromJson(json['deviceDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['buyOrSell'] = this.buyOrSell;
    data['Quantity'] = this.quantity;
    data['price'] = this.price;
    data['battleId'] = this.battleId;
    data['Product'] = this.product;
    data['order_type'] = this.orderType;
    data['TriggerPrice'] = this.triggerPrice;
    data['stopLoss'] = this.stopLoss;
    data['marginxId'] = this.marginxId;
    data['validity'] = this.validity;
    data['variety'] = this.variety;
    data['order_id'] = this.orderId;
    data['subscriptionId'] = this.subscriptionId;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['userId'] = this.userId;
    data['instrumentToken'] = this.instrumentToken;
    data['trader'] = this.trader;
    data['paperTrade'] = this.paperTrade;
    data['tenxTraderPath'] = this.tenxTraderPath;
    data['stopLossPrice'] = this.stopLossPrice;
    data['uId'] = this.uId;
    data['createdBy'] = this.createdBy;
    data['stopProfitPrice'] = this.stopProfitPrice;
    if (this.deviceDetails != null) {
      data['deviceDetails'] = this.deviceDetails!.toJson();
    }
    return data;
  }
}
