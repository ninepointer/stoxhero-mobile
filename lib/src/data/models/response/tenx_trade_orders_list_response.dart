class TenxTradeOrdersListResponse {
  String? status;
  List<TenxTradeOrder>? data;
  int? count;

  TenxTradeOrdersListResponse({this.status, this.data, this.count});

  TenxTradeOrdersListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TenxTradeOrder>[];
      json['data'].forEach((v) {
        data!.add(new TenxTradeOrder.fromJson(v));
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

class TenxTradeOrder {
  String? sId;
  String? product;
  int? quantity;
  int? amount;
  double? averagePrice;
  String? buyOrSell;
  String? orderId;
  String? status;
  TenxSubscriptionId? subscriptionId;
  String? symbol;
  String? tradeTimeUtc;

  TenxTradeOrder(
      {this.sId,
      this.product,
      this.quantity,
      this.amount,
      this.averagePrice,
      this.buyOrSell,
      this.orderId,
      this.status,
      this.subscriptionId,
      this.symbol,
      this.tradeTimeUtc});

  TenxTradeOrder.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = json['Product'];
    quantity = json['Quantity'];
    amount = json['amount'];
    averagePrice = json['average_price'];
    buyOrSell = json['buyOrSell'];
    orderId = json['order_id'];
    status = json['status'];
    subscriptionId = json['subscriptionId'] != null
        ? new TenxSubscriptionId.fromJson(json['subscriptionId'])
        : null;
    symbol = json['symbol'];
    tradeTimeUtc = json['trade_time_utc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Product'] = this.product;
    data['Quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['average_price'] = this.averagePrice;
    data['buyOrSell'] = this.buyOrSell;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    if (this.subscriptionId != null) {
      data['subscriptionId'] = this.subscriptionId!.toJson();
    }
    data['symbol'] = this.symbol;
    data['trade_time_utc'] = this.tradeTimeUtc;
    return data;
  }
}

class TenxSubscriptionId {
  String? sId;
  String? planName;

  TenxSubscriptionId({this.sId, this.planName});

  TenxSubscriptionId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plan_name'] = this.planName;
    return data;
  }
}
