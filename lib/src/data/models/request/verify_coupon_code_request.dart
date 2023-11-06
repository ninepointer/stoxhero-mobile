class VerifyCouponCodeRequest {
  String? code;
  String? product;
  num? orderValue;
  String? platform;
  String? paymentMode;

  VerifyCouponCodeRequest({
    this.code,
    this.product,
    this.orderValue,
    this.platform,
    this.paymentMode,
  });

  VerifyCouponCodeRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    product = json['product'];
    orderValue = json['orderValue'];
    platform = json['platform'];
    paymentMode = json['paymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['product'] = this.product;
    data['orderValue'] = this.orderValue;
    data['platform'] = this.platform;
    data['paymentMode'] = this.paymentMode;
    return data;
  }
}
