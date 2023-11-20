class WalletTransactionsListResponse {
  String? status;
  WalletDetails? data;

  WalletTransactionsListResponse({this.status, this.data});

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

  WalletDetails({this.id, this.userId, this.transactions, this.createdOn, this.createdBy});

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
  ProfilePhoto? profilePhoto;
  String? sId;
  String? kYCStatus;
  String? firstName;
  String? lastName;
  String? state;
  String? accountNumber;
  String? bankName;
  String? ifscCode;
  String? nameAsPerBankAccount;

  UserId(
      {this.profilePhoto,
      this.sId,
      this.kYCStatus,
      this.firstName,
      this.lastName,
      this.state,
      this.accountNumber,
      this.bankName,
      this.ifscCode,
      this.nameAsPerBankAccount});

  UserId.fromJson(Map<String, dynamic> json) {
    profilePhoto = json['profilePhoto'] != null ? new ProfilePhoto.fromJson(json['profilePhoto']) : null;
    sId = json['_id'];
    kYCStatus = json['KYCStatus'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    state = json['state'];
    accountNumber = json['accountNumber'];
    bankName = json['bankName'];
    ifscCode = json['ifscCode'];
    nameAsPerBankAccount = json['nameAsPerBankAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profilePhoto != null) {
      data['profilePhoto'] = this.profilePhoto!.toJson();
    }
    data['_id'] = this.sId;
    data['KYCStatus'] = this.kYCStatus;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['state'] = this.state;
    data['accountNumber'] = this.accountNumber;
    data['bankName'] = this.bankName;
    data['ifscCode'] = this.ifscCode;
    data['nameAsPerBankAccount'] = this.nameAsPerBankAccount;
    return data;
  }
}

class ProfilePhoto {
  String? url;
  String? name;

  ProfilePhoto({this.url, this.name});

  ProfilePhoto.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
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
  String? sId;
  String? transactionStatus;

  WalletTransaction({
    this.title,
    this.description,
    this.transactionDate,
    this.amount,
    this.transactionId,
    this.transactionType,
    this.sId,
    this.transactionStatus,
  });

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    transactionDate = json['transactionDate'];
    amount = json['amount'];
    transactionId = json['transactionId'];
    transactionType = json['transactionType'];
    sId = json['_id'];
    transactionStatus = json['transactionStatus'];
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
    data['transactionStatus'] = this.transactionStatus;
    return data;
  }
}
