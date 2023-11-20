class CheckPaymentStatusResponse {
  String? status;
  String? message;
  PaymentStatusData? data;

  CheckPaymentStatusResponse({
    this.status,
    this.message,
    this.data,
  });

  CheckPaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PaymentStatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaymentStatusData {
  bool? success;
  String? code;
  String? message;
  PaymentStatusData? data;

  PaymentStatusData({
    this.success,
    this.code,
    this.message,
    this.data,
  });

  PaymentStatusData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new PaymentStatusData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PaymentStatus {
  String? merchantId;
  String? merchantTransactionId;
  String? transactionId;
  num? amount;
  String? state;

  PaymentStatus({
    this.merchantId,
    this.merchantTransactionId,
    this.transactionId,
    this.amount,
    this.state,
  });

  PaymentStatus.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantTransactionId = json['merchantTransactionId'];
    transactionId = json['transactionId'];
    amount = json['amount'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['merchantTransactionId'] = this.merchantTransactionId;
    data['transactionId'] = this.transactionId;
    data['amount'] = this.amount;
    data['state'] = this.state;
    return data;
  }
}
