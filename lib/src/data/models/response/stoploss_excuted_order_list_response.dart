class StopLossExecutedOrdersListResponse {
  String? status;
  List<StopLossExecutedOrdersList>? data;

  StopLossExecutedOrdersListResponse({this.status, this.data});

  StopLossExecutedOrdersListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StopLossExecutedOrdersList>[];
      json['data'].forEach((v) {
        data!.add(new StopLossExecutedOrdersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StopLossExecutedOrdersList {
  String? id;
  String? type;
  String? status;
  num? executionPrice;
  int? quantity;
  String? buyOrSell;
  String? symbol;
  num? amount;
  String? time;
  String? excuationTime;

  StopLossExecutedOrdersList(
      {this.id,
      this.type,
      this.status,
      this.executionPrice,
      this.quantity,
      this.buyOrSell,
      this.symbol,
      this.amount,
      this.time,
      this.excuationTime});

  StopLossExecutedOrdersList.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    status = json['status'];
    executionPrice = json['execution_price'];
    quantity = json['Quantity'];
    buyOrSell = json['buyOrSell'];
    symbol = json['symbol'];
    amount = json['amount'];
    time = json['time'];
    excuationTime = json['execution_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['type'] = this.type;
    data['status'] = this.status;
    data['execution_price'] = this.executionPrice;
    data['Quantity'] = this.quantity;
    data['buyOrSell'] = this.buyOrSell;
    data['symbol'] = this.symbol;
    data['amount'] = this.amount;
    data['time'] = this.time;
    data['execution_time'] = this.excuationTime;
    return data;
  }
}
