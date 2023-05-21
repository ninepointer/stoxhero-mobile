class WalletTransactionsListResponse {
  String? status;
  WalletDetails? data;

  WalletTransactionsListResponse({
    this.status,
    this.data,
  });

  WalletTransactionsListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new WalletDetails.fromJson(json['data']) : null;
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

class WalletDetails {
  String? sId;
  UserId? userId;
  List<WalletTransaction>? transactions;
  String? createdOn;
  String? createdBy;

  WalletDetails({
    this.sId,
    this.userId,
    this.transactions,
    this.createdOn,
    this.createdBy,
  });

  WalletDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    if (json['transactions'] != null) {
      transactions = <WalletTransaction>[];
      json['transactions'].forEach((v) {
        transactions!.add(new WalletTransaction.fromJson(v));
      });
    }
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['createdOn'] = this.createdOn;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class UserId {
  String? sId;
  String? firstName;
  String? lastName;

  UserId({this.sId, this.firstName, this.lastName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class WalletTransaction {
  String? title;
  String? description;
  String? transactionDate;
  int? amount;
  String? transactionId;
  String? transactionType;
  String? sId;

  WalletTransaction(
      {this.title,
      this.description,
      this.transactionDate,
      this.amount,
      this.transactionId,
      this.transactionType,
      this.sId});

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    transactionDate = json['transactionDate'];
    amount = json['amount'];
    transactionId = json['transactionId'];
    transactionType = json['transactionType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['transactionDate'] = this.transactionDate;
    data['amount'] = this.amount;
    data['transactionId'] = this.transactionId;
    data['transactionType'] = this.transactionType;
    data['_id'] = this.sId;
    return data;
  }
}
