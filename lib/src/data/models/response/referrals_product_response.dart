class ReferralsProductResponse {
  String? status;
  List<ReferralsProduct>? data;
  String? message;

  ReferralsProductResponse({this.status, this.data, this.message});

  ReferralsProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ReferralsProduct>[];
      json['data'].forEach((v) {
        data!.add(new ReferralsProduct.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ReferralsProduct {
  List<Transaction>? transaction;
  List<Summery>? summery;

  ReferralsProduct({this.transaction, this.summery});

  ReferralsProduct.fromJson(Map<String, dynamic> json) {
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
    if (json['summery'] != null) {
      summery = <Summery>[];
      json['summery'].forEach((v) {
        summery!.add(new Summery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    if (this.summery != null) {
      data['summery'] = this.summery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  String? buyerFirstName;
  String? productName;
  num? payout;
  num? productDiscountedPrice;
  String? date;
  String? transactionId;

  Transaction(
      {this.buyerFirstName,
      this.productName,
      this.payout,
      this.productDiscountedPrice,
      this.date,
      this.transactionId});

  Transaction.fromJson(Map<String, dynamic> json) {
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

class Summery {
  num? payout;
  int? count;

  Summery({this.payout, this.count});

  Summery.fromJson(Map<String, dynamic> json) {
    payout = json['payout'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payout'] = this.payout;
    data['count'] = this.count;
    return data;
  }
}
