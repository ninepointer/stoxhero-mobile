class PendingEditOrderRequest {
  String? executionPrice;

  PendingEditOrderRequest({this.executionPrice});

  PendingEditOrderRequest.fromJson(Map<String, dynamic> json) {
    executionPrice = json['execution_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['execution_price'] = this.executionPrice;
    return data;
  }
}
