class PaymentRequest {
  String? productId;
  String? paymentFor;
  String? merchantTransactionId;
  num? amount;
  String? coupon;
  num? bonusRedemption;

  PaymentRequest({
    this.productId,
    this.paymentFor,
    this.merchantTransactionId,
    this.amount,
    this.coupon,
    this.bonusRedemption,
  });

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    paymentFor = json['paymentFor'];
    merchantTransactionId = json['merchantTransactionId'];
    amount = json['amount'];
    coupon = json['coupon'];
    bonusRedemption = json['bonusRedemption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['paymentFor'] = this.paymentFor;
    data['merchantTransactionId'] = this.merchantTransactionId;
    data['amount'] = this.amount;
    data['coupon'] = this.coupon;
    data['bonusRedemption'] = this.bonusRedemption;
    return data;
  }
}
