class WithdrawalRequest {
  int? amount;

  WithdrawalRequest({this.amount});

  WithdrawalRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    return data;
  }
}
