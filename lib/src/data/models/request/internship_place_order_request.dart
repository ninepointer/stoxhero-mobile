import '../../../app/app.dart';

class InternshipPlaceOrderRequest {
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
  String? uId;
  int? exchangeInstrumentToken;
  String? validity;
  String? variety;
  String? createdBy;
  String? orderId;
  String? subscriptionId;
  String? marginxId;
  String? userId;
  int? instrumentToken;
  String? trader;
  bool? paperTrade;
  bool? internPath;
  DeviceDetails? deviceDetails;

  InternshipPlaceOrderRequest({
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
    this.uId,
    this.exchangeInstrumentToken,
    this.validity,
    this.variety,
    this.createdBy,
    this.orderId,
    this.subscriptionId,
    this.marginxId,
    this.userId,
    this.instrumentToken,
    this.trader,
    this.paperTrade,
    this.internPath,
    this.deviceDetails,
  });

  InternshipPlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symbol = json['symbol'];
    buyOrSell = json['buyOrSell'];
    quantity = json['Quantity'];
    price = json['Price'];
    battleId = json['battleId'];
    product = json['Product'];
    orderType = json['OrderType'];
    triggerPrice = json['TriggerPrice'];
    stopLoss = json['stopLoss'];
    uId = json['uId'];
    exchangeInstrumentToken = json['exchangeInstrumentToken'];
    validity = json['validity'];
    variety = json['variety'];
    createdBy = json['createdBy'];
    orderId = json['order_id'];
    subscriptionId = json['subscriptionId'];
    marginxId = json['marginxId'];
    userId = json['userId'];
    instrumentToken = json['instrumentToken'];
    trader = json['trader'];
    paperTrade = json['paperTrade'];
    internPath = json['internPath'];
    deviceDetails = json['deviceDetails'] != null ? new DeviceDetails.fromJson(json['deviceDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['buyOrSell'] = this.buyOrSell;
    data['Quantity'] = this.quantity;
    data['Price'] = this.price;
    data['battleId'] = this.battleId;
    data['Product'] = this.product;
    data['OrderType'] = this.orderType;
    data['TriggerPrice'] = this.triggerPrice;
    data['stopLoss'] = this.stopLoss;
    data['uId'] = this.uId;
    data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
    data['validity'] = this.validity;
    data['variety'] = this.variety;
    data['createdBy'] = this.createdBy;
    data['order_id'] = this.orderId;
    data['subscriptionId'] = this.subscriptionId;
    data['marginxId'] = this.marginxId;
    data['userId'] = this.userId;
    data['instrumentToken'] = this.instrumentToken;
    data['trader'] = this.trader;
    data['paperTrade'] = this.paperTrade;
    data['internPath'] = this.internPath;
    if (this.deviceDetails != null) {
      data['deviceDetails'] = this.deviceDetails!.toJson();
    }
    return data;
  }
}
