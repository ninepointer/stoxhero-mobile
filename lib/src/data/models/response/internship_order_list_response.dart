class InternshipOrdersListResponse {
  String? status;
  List<InternshipOrdersList>? data;
  int? count;

  InternshipOrdersListResponse({this.status, this.data, this.count});

  InternshipOrdersListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <InternshipOrdersList>[];
      json['data'].forEach((v) {
        data!.add(new InternshipOrdersList.fromJson(v));
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

class InternshipOrdersList {
  String? id;
  String? orderId;
  String? status;
  num? averagePrice;
  int? quantity;
  String? product;
  String? buyOrSell;
  String? symbol;
  num? amount;
  String? tradeTime;
  Batch? batch;

  InternshipOrdersList(
      {this.id,
      this.orderId,
      this.status,
      this.averagePrice,
      this.quantity,
      this.product,
      this.buyOrSell,
      this.symbol,
      this.amount,
      this.tradeTime,
      this.batch});

  InternshipOrdersList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    orderId = json['order_id'];
    status = json['status'];
    averagePrice = json['average_price'];
    quantity = json['Quantity'];
    product = json['Product'];
    buyOrSell = json['buyOrSell'];
    symbol = json['symbol'];
    amount = json['amount'];
    tradeTime = json['trade_time'];
    batch = json['batch'] != null ? new Batch.fromJson(json['batch']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['order_id'] = this.orderId;
    data['status'] = this.status;
    data['average_price'] = this.averagePrice;
    data['Quantity'] = this.quantity;
    data['Product'] = this.product;
    data['buyOrSell'] = this.buyOrSell;
    data['symbol'] = this.symbol;
    data['amount'] = this.amount;
    data['trade_time'] = this.tradeTime;
    if (this.batch != null) {
      data['batch'] = this.batch!.toJson();
    }
    return data;
  }
}

class Batch {
  String? id;
  String? batchName;

  Batch({this.id, this.batchName});

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    batchName = json['batchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['batchName'] = this.batchName;
    return data;
  }
}
