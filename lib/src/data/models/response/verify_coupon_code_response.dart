class VerifyCouponCodeResponse {
  String? status;
  CouponCodeData? data;

  VerifyCouponCodeResponse({
    this.status,
    this.data,
  });

  VerifyCouponCodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new CouponCodeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CouponCodeData {
  num? discount;
  String? discountType;
  String? rewardType;
  num? maxDiscount;

  CouponCodeData({
    this.discount,
    this.discountType,
    this.rewardType,
    this.maxDiscount,
  });

  CouponCodeData.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    discountType = json['discountType'];
    rewardType = json['rewardType'];
    maxDiscount = json['maxDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
    data['discountType'] = this.discountType;
    data['rewardType'] = this.rewardType;
    data['maxDiscount'] = this.maxDiscount;
    return data;
  }
}
