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
  String? id;
  UserId? userId;
  List<WalletTransaction>? transactions;
  String? createdOn;
  String? createdBy;

  WalletDetails({
    this.id,
    this.userId,
    this.transactions,
    this.createdOn,
    this.createdBy,
  });

  WalletDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
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
    data['_id'] = this.id;
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
  String? id;
  String? firstName;
  String? lastName;

  UserId({this.id, this.firstName, this.lastName});

  UserId.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class WalletTransaction {
  String? title;
  String? description;
  String? transactionDate;
  num? amount;
  String? transactionId;
  String? transactionType;
  String? id;

  WalletTransaction({
    this.title,
    this.description,
    this.transactionDate,
    this.amount,
    this.transactionId,
    this.transactionType,
    this.id,
  });

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    transactionDate = json['transactionDate'];
    amount = json['amount'];
    transactionId = json['transactionId'];
    transactionType = json['transactionType'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['transactionDate'] = this.transactionDate;
    data['amount'] = this.amount;
    data['transactionId'] = this.transactionId;
    data['transactionType'] = this.transactionType;
    data['_id'] = this.id;
    return data;
  }
}
