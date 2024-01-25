class MyAffiliateTransctionListResponse {
  String? status;
  List<MyTranscationListData>? data;
  int? count;
  String? message;

  MyAffiliateTransctionListResponse(
      {this.status, this.data, this.count, this.message});

  MyAffiliateTransctionListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MyTranscationListData>[];
      json['data'].forEach((v) {
        data!.add(new MyTranscationListData.fromJson(v));
      });
    }
    count = json['count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['message'] = this.message;
    return data;
  }
}

class MyTranscationListData {
  String? buyerFirstName;
  String? productName;
  num? payout;
  num? productDiscountedPrice;
  String? date;
  String? transactionId;

  MyTranscationListData(
      {this.buyerFirstName,
      this.productName,
      this.payout,
      this.productDiscountedPrice,
      this.date,
      this.transactionId});

  MyTranscationListData.fromJson(Map<String, dynamic> json) {
    buyerFirstName = json['buyer_first_name'];
    productName = json['product_name'];
    payout = json['payout'];
    productDiscountedPrice = json['productDiscountedPrice'];
    date = json['date'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyer_first_name'] = this.buyerFirstName;
    data['product_name'] = this.productName;
    data['payout'] = this.payout;
    data['productDiscountedPrice'] = this.productDiscountedPrice;
    data['date'] = this.date;
    data['transactionId'] = this.transactionId;
    return data;
  }
}
