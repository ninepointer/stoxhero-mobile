class AffiliateSummaryResponse {
  String? status;
  List<AffiliateSummaryData>? data;
  String? message;

  AffiliateSummaryResponse({this.status, this.data, this.message});

  AffiliateSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AffiliateSummaryData>[];
      json['data'].forEach((v) {
        data!.add(new AffiliateSummaryData.fromJson(v));
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

class AffiliateSummaryData {
  List<AffiliateTransaction>? transaction;
  List<AffiliateSummery>? summery;

  AffiliateSummaryData({this.transaction, this.summery});

  AffiliateSummaryData.fromJson(Map<String, dynamic> json) {
    if (json['transaction'] != null) {
      transaction = <AffiliateTransaction>[];
      json['transaction'].forEach((v) {
        transaction!.add(new AffiliateTransaction.fromJson(v));
      });
    }
    if (json['summery'] != null) {
      summery = <AffiliateSummery>[];
      json['summery'].forEach((v) {
        summery!.add(new AffiliateSummery.fromJson(v));
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

class AffiliateTransaction {
  String? buyerFirstName;
  String? productName;
  num? payout;
  num? productDiscountedPrice;
  String? date;
  String? transactionId;

  AffiliateTransaction(
      {this.buyerFirstName,
      this.productName,
      this.payout,
      this.productDiscountedPrice,
      this.date,
      this.transactionId});

  AffiliateTransaction.fromJson(Map<String, dynamic> json) {
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

class AffiliateSummery {
  num? totalProductCount;
  num? totalProductCPayout;

  AffiliateSummery({this.totalProductCount, this.totalProductCPayout});

  AffiliateSummery.fromJson(Map<String, dynamic> json) {
    totalProductCount = json['totalProductCount'];
    totalProductCPayout = json['totalProductCPayout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalProductCount'] = this.totalProductCount;
    data['totalProductCPayout'] = this.totalProductCPayout;
    return data;
  }
}
