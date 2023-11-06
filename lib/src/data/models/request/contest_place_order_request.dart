import '../../../app/app.dart';

class ContestPlaceOrderRequest {
  String? exchange;
  String? symbol;
  String? buyOrSell;
  int? quantity;
  String? stopLoss;
  String? contestId;
  String? battleId;
  String? product;
  String? orderType;
  String? triggerPrice;
  num? stopProfitPrice;
  num? stopLossPrice;
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
  String? price;
  DeviceDetails? deviceDetails;

  ContestPlaceOrderRequest({
    this.exchange,
    this.symbol,
    this.buyOrSell,
    this.quantity,
    this.stopLoss,
    this.contestId,
    this.battleId,
    this.product,
    this.orderType,
    this.triggerPrice,
    this.stopProfitPrice,
    this.stopLossPrice,
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
    this.price,
    this.deviceDetails,
  });

  ContestPlaceOrderRequest.fromJson(Map<String, dynamic> json) {
    exchange = json['exchange'];
    symbol = json['symbol'];
    buyOrSell = json['buyOrSell'];
    quantity = json['Quantity'];
    stopLoss = json['stopLoss'];
    contestId = json['contestId'];
    battleId = json['battleId'];
    product = json['Product'];
    orderType = json['order_type'];
    triggerPrice = json['TriggerPrice'];
    stopProfitPrice = json['stopProfitPrice'];
    stopLossPrice = json['stopLossPrice'];
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
    price = json['price'];
    deviceDetails = json['deviceDetails'] != null ? new DeviceDetails.fromJson(json['deviceDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange'] = this.exchange;
    data['symbol'] = this.symbol;
    data['buyOrSell'] = this.buyOrSell;
    data['Quantity'] = this.quantity;
    data['stopLoss'] = this.stopLoss;
    data['contestId'] = this.contestId;
    data['battleId'] = this.battleId;
    data['Product'] = this.product;
    data['order_type'] = this.orderType;
    data['TriggerPrice'] = this.triggerPrice;
    data['stopProfitPrice'] = this.stopProfitPrice;
    data['stopLossPrice'] = this.stopLossPrice;
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
    data['price'] = this.price;
    if (this.deviceDetails != null) {
      data['deviceDetails'] = this.deviceDetails!.toJson();
    }
    return data;
  }
}
