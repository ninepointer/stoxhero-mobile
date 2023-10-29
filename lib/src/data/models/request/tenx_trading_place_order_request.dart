import '../../../app/app.dart';

// class TenxTradingPlaceOrderRequest {
//   String? exchange;
//   String? symbol;
//   String? buyOrSell;
//   int? quantity;
//   String? price;
//   String? battleId;
//   String? product;
//   String? orderType;
//   String? triggerPrice;
//   String? stopLoss;
//   String? uId;
//   int? exchangeInstrumentToken;
//   String? validity;
//   String? variety;
//   String? createdBy;
//   String? orderId;
//   String? subscriptionId;
//   String? marginxId;
//   String? userId;
//   int? instrumentToken;
//   String? trader;
//   bool? paperTrade;
//   bool? tenxTraderPath;
//   DeviceDetails? deviceDetails;

//   TenxTradingPlaceOrderRequest({
//     this.exchange,
//     this.symbol,
//     this.buyOrSell,
//     this.quantity,
//     this.price,
//     this.battleId,
//     this.product,
//     this.orderType,
//     this.triggerPrice,
//     this.stopLoss,
//     this.uId,
//     this.exchangeInstrumentToken,
//     this.validity,
//     this.variety,
//     this.createdBy,
//     this.orderId,
//     this.subscriptionId,
//     this.marginxId,
//     this.userId,
//     this.instrumentToken,
//     this.trader,
//     this.paperTrade,
//     this.tenxTraderPath,
//     this.deviceDetails,
//   });

//   TenxTradingPlaceOrderRequest.fromJson(Map<String, dynamic> json) {
//     exchange = json['exchange'];
//     symbol = json['symbol'];
//     buyOrSell = json['buyOrSell'];
//     quantity = json['Quantity'];
//     price = json['Price'];
//     battleId = json['battleId'];
//     product = json['Product'];
//     orderType = json['OrderType'];
//     triggerPrice = json['TriggerPrice'];
//     stopLoss = json['stopLoss'];
//     uId = json['uId'];
//     exchangeInstrumentToken = json['exchangeInstrumentToken'];
//     validity = json['validity'];
//     variety = json['variety'];
//     createdBy = json['createdBy'];
//     orderId = json['order_id'];
//     subscriptionId = json['subscriptionId'];
//     marginxId = json['marginxId'];
//     userId = json['userId'];
//     instrumentToken = json['instrumentToken'];
//     trader = json['trader'];
//     paperTrade = json['paperTrade'];
//     tenxTraderPath = json['tenxTraderPath'];
//     deviceDetails = json['deviceDetails'] != null ? new DeviceDetails.fromJson(json['deviceDetails']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['exchange'] = this.exchange;
//     data['symbol'] = this.symbol;
//     data['buyOrSell'] = this.buyOrSell;
//     data['Quantity'] = this.quantity;
//     data['Price'] = this.price;
//     data['battleId'] = this.battleId;
//     data['Product'] = this.product;
//     data['OrderType'] = this.orderType;
//     data['TriggerPrice'] = this.triggerPrice;
//     data['stopLoss'] = this.stopLoss;
//     data['uId'] = this.uId;
//     data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
//     data['validity'] = this.validity;
//     data['variety'] = this.variety;
//     data['createdBy'] = this.createdBy;
//     data['order_id'] = this.orderId;
//     data['subscriptionId'] = this.subscriptionId;
//     data['marginxId'] = this.marginxId;
//     data['userId'] = this.userId;
//     data['instrumentToken'] = this.instrumentToken;
//     data['trader'] = this.trader;
//     data['paperTrade'] = this.paperTrade;
//     data['tenxTraderPath'] = this.tenxTraderPath;
//     if (this.deviceDetails != null) {
//       data['deviceDetails'] = this.deviceDetails!.toJson();
//     }
//     return data;
//   }
// }
// class TenxTradingPlaceOrderRequest {
//   String? exchange;
//   String? symbol;
//   String? buyOrSell;
//   int? quantity;
//   String? battleId;
//   String? product;
//   String? orderType;
//   String? stopProfitPrice;
//   String? stopLossPrice;
//   String? uId;
//   int? exchangeInstrumentToken;
//   String? validity;
//   String? variety;
//   String? createdBy;
//   String? orderId;
//   String? subscriptionId;
//   String? marginxId;
//   String? userId;
//   int? instrumentToken;
//   String? trader;
//   bool? paperTrade;
//   bool? tenxTraderPath;
//   DeviceDetails? deviceDetails;

//   TenxTradingPlaceOrderRequest({
//     this.exchange,
//     this.symbol,
//     this.buyOrSell,
//     this.quantity,
//     this.battleId,
//     this.product,
//     this.orderType,
//     this.stopProfitPrice,
//     this.stopLossPrice,
//     this.uId,
//     this.exchangeInstrumentToken,
//     this.validity,
//     this.variety,
//     this.createdBy,
//     this.orderId,
//     this.subscriptionId,
//     this.marginxId,
//     this.userId,
//     this.instrumentToken,
//     this.trader,
//     this.paperTrade,
//     this.tenxTraderPath,
//     this.deviceDetails,
//   });

//   TenxTradingPlaceOrderRequest.fromJson(Map<String, dynamic> json) {
//     exchange = json['exchange'];
//     symbol = json['symbol'];
//     buyOrSell = json['buyOrSell'];
//     quantity = json['Quantity'];
//     battleId = json['battleId'];
//     product = json['Product'];
//     orderType = json['OrderType'];
//     stopProfitPrice = json['stopProfitPrice'];
//     stopLossPrice = json['stopLossPrice'];
//     uId = json['uId'];
//     exchangeInstrumentToken = json['exchangeInstrumentToken'];
//     validity = json['validity'];
//     variety = json['variety'];
//     createdBy = json['createdBy'];
//     orderId = json['order_id'];
//     subscriptionId = json['subscriptionId'];
//     marginxId = json['marginxId'];
//     userId = json['userId'];
//     instrumentToken = json['instrumentToken'];
//     trader = json['trader'];
//     paperTrade = json['paperTrade'];
//     tenxTraderPath = json['tenxTraderPath'];
//     deviceDetails = json['deviceDetails'] != null ? new DeviceDetails.fromJson(json['deviceDetails']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['exchange'] = this.exchange;
//     data['symbol'] = this.symbol;
//     data['buyOrSell'] = this.buyOrSell;
//     data['Quantity'] = this.quantity;
//     data['battleId'] = this.battleId;
//     data['Product'] = this.product;
//     data['OrderType'] = this.orderType;
//     data['stopProfitPrice'] = this.stopProfitPrice;
//     data['stopLossPrice'] = this.stopLossPrice;
//     data['uId'] = this.uId;
//     data['exchangeInstrumentToken'] = this.exchangeInstrumentToken;
//     data['validity'] = this.validity;
//     data['variety'] = this.variety;
//     data['createdBy'] = this.createdBy;
//     data['order_id'] = this.orderId;
//     data['subscriptionId'] = this.subscriptionId;
//     data['marginxId'] = this.marginxId;
//     data['userId'] = this.userId;
//     data['instrumentToken'] = this.instrumentToken;
//     data['trader'] = this.trader;
//     data['paperTrade'] = this.paperTrade;
//     data['tenxTraderPath'] = this.tenxTraderPath;
//     if (this.deviceDetails != null) {
//       data['deviceDetails'] = this.deviceDetails!.toJson();
//     }

//     return data;
//   }
// }
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
    price = json['Price'];
    battleId = json['battleId'];
    product = json['Product'];
    orderType = json['OrderType'];
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
    data['Price'] = this.price;
    data['battleId'] = this.battleId;
    data['Product'] = this.product;
    data['OrderType'] = this.orderType;
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
